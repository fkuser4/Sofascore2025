//
//  EventDetailsHeaderView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class EventDetailsHeaderView: BaseView {
  private var homeTeamLogoImageView: UIImageView = .init()
  private var awayTeamLogoImageView: UIImageView = .init()

  private var homeTeamLabel: UILabel = .init()
  private var awayTeamLabel: UILabel = .init()

  private var matchTimeLabel: UILabel = .init()
  private var matchStatusLabel: UILabel = .init()

  private var centerStack: UIStackView = .init()

  func configure(with viewModel: EventDetailsHeaderViewModel) {
    homeTeamLogoImageView.loadImage(from: viewModel.homeTeamLogoURL)
    awayTeamLogoImageView.loadImage(from: viewModel.awayTeamLogoURL)

    homeTeamLabel.text = viewModel.homeTeamName
    awayTeamLabel.text = viewModel.awayTeamName

    matchTimeLabel.attributedText = viewModel.matchTime
    matchStatusLabel.attributedText = viewModel.matchStatus
  }

  override func addViews() {
    addSubview(homeTeamLogoImageView)
    addSubview(awayTeamLogoImageView)
    centerStack.addArrangedSubview(matchStatusLabel)
    centerStack.addArrangedSubview(matchTimeLabel)
    addSubview(centerStack)
    addSubview(homeTeamLabel)
    addSubview(awayTeamLabel)
  }

  override func styleViews() {
    centerStack.axis = .vertical
    centerStack.alignment = .center
    centerStack.spacing = 4

    homeTeamLogoImageView.contentMode = .scaleAspectFit
    awayTeamLogoImageView.contentMode = .scaleAspectFit

    homeTeamLabel.font = .bodyBold
    awayTeamLabel.font = .bodyBold

    homeTeamLabel.textColor = .primary
    awayTeamLabel.textColor = .primary

    homeTeamLabel.numberOfLines = 2
    homeTeamLabel.lineBreakMode = .byWordWrapping
    homeTeamLabel.textAlignment = .center

    awayTeamLabel.numberOfLines = 2
    awayTeamLabel.lineBreakMode = .byWordWrapping
    awayTeamLabel.textAlignment = .center
  }

  override func setupConstraints() {
    homeTeamLogoImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.leading.equalToSuperview().inset(44)
      make.top.equalToSuperview().inset(16)
    }

    awayTeamLogoImageView.snp.makeConstraints { make in
      make.size.centerY.equalTo(homeTeamLogoImageView)
      make.trailing.equalToSuperview().inset(44)
    }

    homeTeamLabel.snp.makeConstraints { make in
      make.centerX.equalTo(homeTeamLogoImageView)
      make.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(8)
      make.bottom.lessThanOrEqualToSuperview().inset(15)
      make.leading.greaterThanOrEqualToSuperview().inset(16)
    }

    awayTeamLabel.snp.makeConstraints { make in
      make.centerX.equalTo(awayTeamLogoImageView)
      make.centerY.equalTo(homeTeamLabel)
      make.bottom.lessThanOrEqualToSuperview().inset(15)
      make.trailing.greaterThanOrEqualToSuperview().inset(16)
    }

    centerStack.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.centerX.equalToSuperview()
    }
  }
}
