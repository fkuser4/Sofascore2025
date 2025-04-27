//
//  SettingsOverviewView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 27.04.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class SettingsOverviewView: BaseView {
  private var nameLabel: UILabel = .init()
  private var eventsCountLabel: UILabel = .init()
  private var leagueCountLabel: UILabel = .init()
  private var logoutButton: UIButton = .init()
  private var stackView: UIStackView = .init()
  var didTapLogout: (() -> Void)?
  func setName(_ text: String) {
    nameLabel.text = text
  }

  func setEventsCount(_ text: String) {
    eventsCountLabel.text = text
  }

  func setLeaguesCount(_ text: String) {
    leagueCountLabel.text = text
  }

  override func addViews() {
    addSubview(stackView)
    [nameLabel, eventsCountLabel, leagueCountLabel, logoutButton].forEach {
      stackView.addArrangedSubview($0)
    }
  }

  override func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    [nameLabel, eventsCountLabel, leagueCountLabel, logoutButton].forEach {
      $0.snp.makeConstraints { make in
        make.leading.equalToSuperview().inset(15)
      }
    }

    logoutButton.snp.makeConstraints { make in
      make.width.equalTo(100)
      make.height.equalTo(30)
    }
  }

  override func styleViews() {
    [nameLabel, eventsCountLabel, leagueCountLabel].forEach {
      $0.font = .bodyRegular
      $0.textColor = .primary
    }

    logoutButton.setTitle("Logout", for: .normal)
    logoutButton.backgroundColor = .black
    logoutButton.layer.cornerRadius = 6
    logoutButton.titleLabel?.font = .bodyRegular

    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 20
  }

  override func setupBinding() {
    logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
  }

  @objc private func logoutTapped() {
    didTapLogout?()
  }
}
