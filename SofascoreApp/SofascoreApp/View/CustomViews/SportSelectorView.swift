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


  func configure(with sports: [SportType]) {
    for sport in sports {
      let icon = UIImage(named: sport.iconName)
      let button = SportSelectorButton(icon: icon, title: sport.title)
      button.tag = sport.rawValue
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
      stackView.addArrangedSubview(button)
      buttons.append(button)
    }
  }

  override func addViews() {
    addSubview(stackView)
  }

  override func styleViews() {
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 0
    stackView.backgroundColor = .sportSelectorBackground
  }

  override func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  @objc private func buttonTapped(_ sender: UIControl) {
    guard let sport = SportType(rawValue: sender.tag) else { return }
    onTap?(sport)
  }
}
