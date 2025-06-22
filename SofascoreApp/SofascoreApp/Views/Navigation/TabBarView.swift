//  SportSelectorView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class TabBarView: BaseView {
  public var onItemSelected: ((Int) -> Void)?

  private let stackView: UIStackView = .init()
  private var buttons: [TapBarButton] = []
  private let underlineTrackView = UIView()
  private let underlineView = UIView()

  private var currentIndex = 0

  public func configure(with items: [TabBarItem], initialIndex: Int = 0) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    buttons.removeAll()

    for (index, item) in items.enumerated() {
      let button = TapBarButton(icon: item.iconName, title: item.title)
      button.onTap = { [weak self] in
        self?.selectItem(at: index)
      }
      buttons.append(button)
      stackView.addArrangedSubview(button)
    }

    currentIndex = initialIndex
    if initialIndex < buttons.count {
      DispatchQueue.main.async { [weak self] in
        guard let self = self, self.buttons.indices.contains(initialIndex) else { return }
        self.updateUnderlineView(for: self.buttons[initialIndex], animated: false)
      }
    }
  }

  public func selectItem(at index: Int) {
    guard index < buttons.count else { return }
    currentIndex = index
    let selectedButton = buttons[index]
    updateUnderlineView(for: selectedButton, animated: true)
    onItemSelected?(index)
  }

  public func updateUnderlinePosition(from fromIndex: Int, to toIndex: Int, progress: CGFloat) {
    guard buttons.indices.contains(fromIndex), buttons.indices.contains(toIndex) else {
      return
    }

    let fromButton = buttons[fromIndex]
    let toButton = buttons[toIndex]

    animateUnderlineBetween(from: fromButton, to: toButton, progress: progress)
  }

  private func animateUnderlineBetween(from fromView: UIView, to toView: UIView, progress: CGFloat) {
    let fromFrame = fromView.frame
    let toFrame   = toView.frame

    let fromLeading = fromFrame.minX + 8
    let fromWidth   = fromFrame.width - 16

    let toLeading   = toFrame.minX + 8
    let toWidth     = toFrame.width - 16

    let interpolatedLeading = fromLeading + (toLeading - fromLeading) * progress
    let interpolatedWidth   = fromWidth + (toWidth - fromWidth) * progress

    underlineView.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalToSuperview().offset(interpolatedLeading)
      $0.width.equalTo(interpolatedWidth)
    }
  }

  override func addViews() {
    addSubview(stackView)
    addSubview(underlineTrackView)
    underlineTrackView.addSubview(underlineView)
  }

  override func styleViews() {
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 0
    stackView.backgroundColor = .primaryBackgroundColor

    underlineTrackView.backgroundColor = .primaryBackgroundColor

    underlineView.backgroundColor = .textOnPrimaryBackgroundColor
    underlineView.layer.cornerRadius = 2
    underlineView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    underlineView.clipsToBounds = true
    underlineView.isUserInteractionEnabled = false
  }

  override func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.top.trailing.leading.equalToSuperview()
    }

    underlineTrackView.snp.makeConstraints {
      $0.height.equalTo(4)
      $0.top.equalTo(stackView.snp.bottom)
      $0.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
  }

  private func updateUnderlineView(for button: UIView, animated: Bool) {
    underlineView.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(button.snp.leading).offset(8)
      $0.width.equalTo(button.snp.width).offset(-16)
    }

    if animated {
      UIView.animate(withDuration: 0.25) {
        self.layoutIfNeeded()
      }
    } else {
      self.layoutIfNeeded()
    }
  }
}
