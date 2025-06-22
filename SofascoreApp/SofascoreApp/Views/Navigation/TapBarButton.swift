//
//  BaseTapBarButton.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import SnapKit
import UIKit

class TapBarButton: UIControl {
  public var onTap: (() -> Void)?
  private lazy var iconImageView: UIImageView = .init()
  private let titleLabel: UILabel = .init()

  init(icon: String?, title: String) {
    super.init(frame: .zero)
    self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    if let icon = icon {
      setupWithButtonIcon(icon: icon, title: title)
    } else {
      setupWithoutButtonIcon(title: title)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupWithButtonIcon(icon: String, title: String) {
    addSubview(iconImageView)
    addSubview(titleLabel)

    iconImageView.image = UIImage(named: icon)
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.tintColor = .textOnPrimaryBackgroundColor

    titleLabel.text = title
    titleLabel.font = .bodyRegular
    titleLabel.textAlignment = .center
    titleLabel.textColor = .textOnPrimaryBackgroundColor

    iconImageView.snp.makeConstraints {
      $0.size.equalTo(16)
      $0.top.equalToSuperview().offset(4)
      $0.centerX.equalToSuperview()
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(iconImageView.snp.bottom).offset(4)
      $0.leading.trailing.lessThanOrEqualToSuperview().inset(8)
      $0.bottom.equalToSuperview().inset(4)
      $0.centerX.equalToSuperview()
    }
  }

  private func setupWithoutButtonIcon(title: String) {
    addSubview(titleLabel)

    titleLabel.text = title
    titleLabel.font = .bodyRegular
    titleLabel.textAlignment = .center
    titleLabel.textColor = .textOnPrimaryBackgroundColor

    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.leading.trailing.lessThanOrEqualToSuperview().inset(8)
      $0.bottom.equalToSuperview().inset(12)
      $0.centerX.equalToSuperview()
    }
  }

  @objc private func buttonTapped() {
    onTap?()
  }
}
