//
//  EventDetailsTitleView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 14.04.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class EventDetailsTitleView: BaseView {
  private var leagueLogoImageView: UIImageView = .init()
  private var titleLabel: UILabel = .init()

  func configure(league: League, sport: String) {
    leagueLogoImageView.loadImage(from: league.logoUrl)
    titleLabel.text = "\(sport), \(league.country.name), \(league.name)"
  }

  override func addViews() {
    addSubview(leagueLogoImageView)
    addSubview(titleLabel)
  }

  override func setupConstraints() {
    leagueLogoImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.size.equalTo(16)
      make.leading.equalToSuperview()
    }

    titleLabel.snp.makeConstraints { make in
      make.centerY.equalTo(leagueLogoImageView)
      make.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
    }
  }

  override func styleViews() {
    titleLabel.font = .bodyLight
    titleLabel.textColor = .secondary
  }
}
