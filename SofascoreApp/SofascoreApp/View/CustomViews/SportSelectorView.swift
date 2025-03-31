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
  private var buttons: [SportSelectorButton] = []
  private let underlineTrackView = UIView()
  private let underlineView = UIView()

  func configure(with sports: [SportType]) {
    for sport in sports {
      let icon = UIImage(named: sport.iconName)
      let button = SportSelectorButton(icon: icon, title: sport.title)
      button.tag = sport.rawValue
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
      stackView.addArrangedSubview(button)
      buttons.append(button)
    }

    guard let firstButton = buttons.first else { return }

    underlineView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(firstButton.snp.leading).offset(8)
      $0.trailing.equalTo(firstButton.snp.trailing).offset(-8)
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
    stackView.backgroundColor = .sportSelectorBackground

    underlineTrackView.backgroundColor = .sportSelectorBackground

    underlineView.backgroundColor = .sportSelectorText
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

  @objc private func buttonTapped(_ sender: UIControl) {
    guard let sport = SportType(rawValue: sender.tag),
      let selectedButton = sender as? SportSelectorButton else { return }

    underlineView.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(selectedButton.snp.leading).offset(8)
      $0.trailing.equalTo(selectedButton.snp.trailing).offset(-8)
    }

    UIView.animate(withDuration: 0.25) {
      self.layoutIfNeeded()
    }

    onTap?(sport)
  }
}
