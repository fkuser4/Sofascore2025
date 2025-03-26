//
//  EventView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import Foundation
import SofaAcademic
import UIKit
import SnapKit

class EventView: BaseView {
  private let homeTeam: TeamView = .init()
  private let awayTeam: TeamView = .init()
  private let timeView: TimeView = .init()
  private var homeScore = UILabel()
  private var awayScore = UILabel()
  private let leftBorderView: UIView = .init()

  func configure(with eventViewModel: EventViewModel) {
    homeScore.text = eventViewModel.homeScore
    awayScore.text = eventViewModel.awayScore
    homeScore.textColor = eventViewModel.homeScoreTextColor
    awayScore.textColor = eventViewModel.awayScoreTextColor

    homeTeam.configure(
      teamLogoUrl: eventViewModel.homeTeamLogoURL,
      teamName: eventViewModel.homeTeamName,
      textColor: eventViewModel.homeTeamTextColor)

    awayTeam.configure(
      teamLogoUrl: eventViewModel.awayTeamLogoURL,
      teamName: eventViewModel.awayTeamName,
      textColor: eventViewModel.awayTeamTextColor)

    timeView.configure(
      matchTime: eventViewModel.matchStartTime,
      statusText: eventViewModel.matchStatusText,
      statusTextColor: eventViewModel.timeTextColor)
  }

  override func addViews() {
    addSubview(homeTeam)
    addSubview(awayTeam)
    addSubview(timeView)
    addSubview(homeScore)
    addSubview(awayScore)
    addSubview(leftBorderView)
  }

  override func styleViews() {
    homeScore.font = .bodyRegular
    awayScore.font = .bodyRegular

    homeScore.textAlignment = .right
    awayScore.textAlignment = .right

    leftBorderView.backgroundColor = .secondary
  }

  override func setupConstraints() {
    timeView.snp.makeConstraints { make in
      make.top.leading.height.equalToSuperview()
      make.width.equalTo(64)
    }

    leftBorderView.snp.makeConstraints { make in
      make.leading.equalTo(timeView.snp.trailing)
      make.height.equalTo(40)
      make.centerY.equalToSuperview()
      make.width.equalTo(1)
    }

    homeTeam.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.leading.equalTo(leftBorderView.snp.trailing).offset(16)
      make.width.equalTo(192)
    }

    awayTeam.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(10)
      make.leading.equalTo(leftBorderView.snp.trailing).offset(16)
      make.width.equalTo(192)
    }

    homeScore.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().inset(16)
      make.width.equalTo(32)
    }

    awayScore.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(10)
      make.trailing.equalToSuperview().inset(16)
      make.width.equalTo(32)
    }
  }
}
