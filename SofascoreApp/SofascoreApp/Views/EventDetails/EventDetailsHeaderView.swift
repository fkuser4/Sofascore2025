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

  private var centerStack: UIStackView = .init()

  private var scoreView: ScoreView = .init()
  private var matchStartDateLabel: UILabel = .init()
  private var matchTimeLabel: UILabel = .init()

  private var currentViewModel: EventDetailsHeaderViewModel?

  var onTeamTap: ((Team) -> Void)?

  func configure(with viewModel: EventDetailsHeaderViewModel) {
    currentViewModel = viewModel

    homeTeamLogoImageView.loadImage(from: viewModel.homeTeamLogoURL)
    awayTeamLogoImageView.loadImage(from: viewModel.awayTeamLogoURL)

    homeTeamLabel.text = viewModel.homeTeamName
    awayTeamLabel.text = viewModel.awayTeamName

    matchTimeLabel.text = viewModel.matchTime
    matchTimeLabel.textColor = viewModel.matchTimeColor

    if viewModel.scoreAvailable {
      centerStack.addArrangedSubview(scoreView)
      centerStack.addArrangedSubview(matchTimeLabel)
      scoreView.configure(with: viewModel)
    } else {
      matchStartDateLabel.text = viewModel.matchStartDate
      centerStack.addArrangedSubview(matchStartDateLabel)
      centerStack.addArrangedSubview(matchTimeLabel)
    }
  }

  override func addViews() {
    addSubview(homeTeamLogoImageView)
    addSubview(awayTeamLogoImageView)
    addSubview(centerStack)
    addSubview(homeTeamLabel)
    addSubview(awayTeamLabel)
  }

  override func styleViews() {
    self.backgroundColor = .white

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

    matchStartDateLabel.textColor = .primary
    matchStartDateLabel.font = .bodyLight

    matchTimeLabel.font = .bodyLight

    homeTeamLogoImageView.isUserInteractionEnabled = true
    homeTeamLabel.isUserInteractionEnabled = true
    awayTeamLogoImageView.isUserInteractionEnabled = true
    awayTeamLabel.isUserInteractionEnabled = true
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
      make.bottom.equalToSuperview().inset(15)
      make.leading.greaterThanOrEqualToSuperview().inset(16)
    }

    awayTeamLabel.snp.makeConstraints { make in
      make.centerX.equalTo(awayTeamLogoImageView)
      make.centerY.equalTo(homeTeamLabel)
      make.bottom.equalToSuperview().inset(15)
      make.trailing.lessThanOrEqualToSuperview().inset(16)
    }

    centerStack.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
      make.leading.greaterThanOrEqualTo(homeTeamLabel.snp.trailing)
      make.trailing.lessThanOrEqualTo(awayTeamLabel.snp.leading)
    }
  }

  override func setupGestureRecognizers() {
    let homeLogoTap = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
    let homeLabelTap = UITapGestureRecognizer(target: self, action: #selector(homeTapped))

    homeTeamLogoImageView.addGestureRecognizer(homeLogoTap)
    homeTeamLabel.addGestureRecognizer(homeLabelTap)

    let awayLogoTap = UITapGestureRecognizer(target: self, action: #selector(awayTapped))
    let awayLabelTap = UITapGestureRecognizer(target: self, action: #selector(awayTapped))

    awayTeamLogoImageView.addGestureRecognizer(awayLogoTap)
    awayTeamLabel.addGestureRecognizer(awayLabelTap)
  }

  @objc private func homeTapped() {
    guard let team = currentViewModel?.event.homeTeam else { return }
    onTeamTap?(team)
  }

  @objc private func awayTapped() {
    guard let team = currentViewModel?.event.awayTeam else { return }
    onTeamTap?(team)
  }
}
