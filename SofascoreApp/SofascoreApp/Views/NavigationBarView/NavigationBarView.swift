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
  private var titleView: UIView?

  func configure(with config: NavigationBarConfiguration) {
    titleView?.removeFromSuperview()
    titleView = nil

    titleLabel.isHidden = true

    backButton.tintColor = config.backIconColor
    backgroundColor = config.backgroundColor

    if let customTitleView = config.titleView {
      addSubview(customTitleView)

      customTitleView.snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.leading.equalTo(backButton.snp.trailing)
        make.trailing.lessThanOrEqualToSuperview()
      }

      self.titleView = customTitleView
    } else if let title = config.title {
      titleLabel.text = title
      titleLabel.isHidden = false
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
