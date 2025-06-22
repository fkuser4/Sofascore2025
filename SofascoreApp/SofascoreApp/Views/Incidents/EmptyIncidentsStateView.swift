//
//  EmptyIncidentsStateView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.06.2025..
//
import SnapKit
import SofaAcademic
import UIKit

final class EmptyIncidentsStateView: BaseView {
  private let containerView: UIView = .init()
  private let messageContainerView: UIView = .init()
  private let messageLabel: UILabel = .init()
  private let actionButton: UIButton = .init()
  private let gradientSeparatorView: GradientSeparatorView = .init()

  var didTapDetails: (() -> Void)?

  override func addViews() {
    addSubview(gradientSeparatorView)
    addSubview(containerView)
    containerView.addSubview(messageContainerView)
    containerView.addSubview(actionButton)
    messageContainerView.addSubview(messageLabel)
  }

  override func styleViews() {
    messageLabel.text = "No results yet."
    messageLabel.font = .bodyRegular
    messageLabel.textColor = .secondary
    messageLabel.textAlignment = .center

    var config = UIButton.Configuration.plain()

    let attributedTitle = AttributedString("View Tournament Details", attributes: AttributeContainer([
      .font: UIFont.tournamentDetailsButton,
      .foregroundColor: UIColor.primaryBackgroundColor
    ]))

    config.attributedTitle = attributedTitle
    config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

    config.background.cornerRadius = 2
    config.background.strokeColor = .primaryBackgroundColor
    config.background.strokeWidth = 2

    actionButton.configuration = config


    containerView.backgroundColor = .white

    messageContainerView.backgroundColor = .contentBackground
    messageContainerView.layer.cornerRadius = 8
    messageLabel.layer.masksToBounds = true
  }

  override func setupConstraints() {
    gradientSeparatorView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(8)
    }

    containerView.snp.makeConstraints { make in
      make.top.equalTo(gradientSeparatorView.snp.bottom)
      make.trailing.leading.equalToSuperview()
    }

    messageContainerView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.leading.equalToSuperview().offset(8)
      make.trailing.equalToSuperview().inset(8)
    }

    messageLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(16)
      make.centerX.equalToSuperview()
    }

    actionButton.snp.makeConstraints { make in
      make.top.equalTo(messageContainerView.snp.bottom).offset(16)
      make.leading.equalToSuperview().offset(74)
      make.trailing.equalToSuperview().inset(74)
      make.bottom.equalToSuperview().inset(32)
    }
  }

  override func setupBinding() {
    actionButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
  }

  @objc private func detailsButtonTapped() {
    didTapDetails?()
  }
}
