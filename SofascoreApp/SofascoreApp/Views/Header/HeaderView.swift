//
//  HeaderView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class HeaderView: BaseView {
  private let headerTitleView = UIImageView()

  private let settingsButton = UIButton()
  private let trophyButton = UIButton()

  private let settingsIcon = UIImage(named: "ic_settings")
  private let trophyIcon = UIImage(named: "ic_trophy")
  private let headerTitleIcon = UIImage(named: "ic_header_title")

  var didTapSettingsButton: (() -> Void)?
  var didTapTrophyButton: (() -> Void)?

  override func styleViews() {
    backgroundColor = .primaryBackgroundColor

    headerTitleView.image = headerTitleIcon
    headerTitleView.contentMode = .scaleAspectFit
    headerTitleView.tintColor = .textOnPrimaryBackgroundColor

    settingsButton.setBackgroundImage(settingsIcon, for: .normal)
    settingsButton.imageView?.contentMode = .scaleAspectFit

    trophyButton.setBackgroundImage(trophyIcon, for: .normal)
    trophyButton.imageView?.contentMode = .scaleAspectFit
  }

  override func setupBinding() {
    settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    trophyButton.addTarget(self, action: #selector(trophyTapped), for: .touchUpInside)
  }

  override func addViews() {
    addSubview(headerTitleView)
    addSubview(settingsButton)
    addSubview(trophyButton)
  }

  override func setupConstraints() {
    headerTitleView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.height.equalTo(20)
      make.top.bottom.equalToSuperview().inset(14)
    }

    settingsButton.snp.makeConstraints { make in
      make.size.equalTo(20)
      make.trailing.equalToSuperview().inset(16)
      make.centerY.equalTo(headerTitleView)
    }

    trophyButton.snp.makeConstraints { make in
      make.size.centerY.equalTo(settingsButton)
      make.trailing.equalTo(settingsButton.snp.leading).offset(-26)
    }
  }

  @objc func settingsTapped() {
    didTapSettingsButton?()
  }

  @objc func trophyTapped() {
    didTapTrophyButton?()
  }
}
