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
  private let backIconImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate)
  private var titleView: UIView?

  var didTapBackButton: (() -> Void)?

  func configure(with config: NavigationBarConfiguration) {
    titleView?.removeFromSuperview()
    let newTitleView = config.titleView
    self.titleView = newTitleView
    addSubview(newTitleView)

    newTitleView.snp.makeConstraints { make in
      make.leading.equalTo(backButton.snp.trailing).offset(config.titleLeadingOffset)
      make.centerY.equalTo(backButton)
    }

    backButton.tintColor = config.backIconColor
    backgroundColor = config.backgroundColor
  }

  override func addViews() {
    addSubview(backButton)
  }

  override func setupConstraints() {
    backButton.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.leading.equalToSuperview().inset(20)
      make.top.bottom.equalToSuperview().inset(16)
    }
  }

  override func styleViews() {
    backButton.setImage(backIconImage, for: .normal)
    backButton.imageView?.contentMode = .scaleAspectFit
  }

  override func setupBinding() {
    backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
  }

  @objc private func backTapped() {
    didTapBackButton?()
  }
}
