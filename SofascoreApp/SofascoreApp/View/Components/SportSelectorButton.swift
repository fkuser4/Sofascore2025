//
//  SportSelectorButton.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit

final class SportSelectorButton: UIControl {
  private let iconImageView = UIImageView()
  private let titleLabel = UILabel()

  init(icon: UIImage?, title: String) {
    super.init(frame: .zero)

    guard let icon = icon else {
      return
    }

    setup(icon: icon, title: title)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup(icon: UIImage, title: String) {
    addSubview(iconImageView)
    addSubview(titleLabel)

    iconImageView.image = icon
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.tintColor = .sportSelectorText

    titleLabel.text = title
    titleLabel.font = .bodyRegular
    titleLabel.textAlignment = .center
    titleLabel.textColor = .sportSelectorText

    iconImageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(4)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(16)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(iconImageView.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview().inset(8)
      $0.bottom.equalToSuperview().inset(4)
    }
  }
}
