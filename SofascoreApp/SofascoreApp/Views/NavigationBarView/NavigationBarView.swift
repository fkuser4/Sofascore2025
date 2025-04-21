//
//  NavigationBarView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import UIKit
import SofaAcademic
import SnapKit

final class NavigationBarView: BaseView {
  private let backButton = UIButton()
  private var titleLabel: UILabel = .init()
  var didTapBackButton: (() -> Void)?

  func configure(with config: NavigationBarConfiguration) {
    backButton.tintColor = config.backIconColor
    backgroundColor = config.backgroundColor

    guard let titleView = config.titleView else {
      if let title = config.title {
        titleLabel.text = title
        titleLabel.isHidden = false
      }
      return
    }

    addSubview(titleView)

    titleView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(backButton.snp.trailing)
    }
  }

  override func addViews() {
    addSubview(backButton)
    addSubview(titleLabel)
  }

  override func setupConstraints() {
    backButton.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.leading.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(16)
    }

    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview()
      make.leading.equalTo(backButton.snp.leading).offset(36)
    }
  }

  override func styleViews() {
    titleLabel.isHidden = true
    titleLabel.font = .screenHeadline
    titleLabel.textColor = .textOnPrimaryBackgroundColor

    backButton.setImage(.icBack, for: .normal)
    backButton.imageView?.contentMode = .scaleAspectFit
  }

  override func setupBinding() {
    backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
  }

  @objc private func backTapped() {
    didTapBackButton?()
  }
}
