//
//  SportSelectorView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class SportSelectorView: BaseView {
  var onTap: ((SportType) -> Void)?

  private let stackView: UIStackView = .init()
  private var buttons: [SportType: SportSelectorButton] = [:]
  private let underlineTrackView = UIView()
  private let underlineView = UIView()

  func configure(with sports: [SportType], initialSport: SportType) {
    for view in stackView.arrangedSubviews {
      stackView.removeArrangedSubview(view)
      view.removeFromSuperview()
    }

    for sport in sports {
      let icon = UIImage(named: sport.iconName)
      let button = SportSelectorButton(icon: icon, title: sport.title)
      button.onTap = { [weak self] in
        self?.updateUnderlineView(for: button, animated: true)
        self?.onTap?(sport)
      }

      stackView.addArrangedSubview(button)
      buttons[sport] = button
    }

    guard let button = buttons[initialSport] else { return }
    updateUnderlineView(for: button, animated: false)
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
      $0.trailing.equalTo(button.snp.trailing).offset(-8)
    }
    if animated {
      UIView.animate(withDuration: 0.25) {
        self.layoutIfNeeded()
      }
    }
  }
}
