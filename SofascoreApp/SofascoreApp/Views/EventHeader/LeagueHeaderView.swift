//
//  LeagueView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class LeagueHeaderView: BaseView {
  private var leagueLogoImageView: UIImageView = .init()
  private var leagueTitleView: LeagueTitleView = .init()

  func configure(with leagueHeaderViewModel: LeagueHeaderViewModel?) {
    if let leagueHeaderViewModel = leagueHeaderViewModel {
      leagueLogoImageView.image = .leagueLogoPlaceholder
      leagueLogoImageView.loadImage(from: leagueHeaderViewModel.logoURL)
      leagueTitleView.configure(
        leagueName: leagueHeaderViewModel.leagueName,
        country: leagueHeaderViewModel.countryName)
    } else {
      leagueLogoImageView.image = nil
      leagueTitleView.configure(leagueName: nil, country: nil)
    }
  }

  override func addViews() {
    addSubview(leagueLogoImageView)
    addSubview(leagueTitleView)
  }

  override func setupConstraints() {
    leagueLogoImageView.snp.makeConstraints {
      $0.size.equalTo(32)
      $0.top.bottom.equalToSuperview().inset(12)
      $0.leading.equalToSuperview().offset(16)
    }

    leagueTitleView.snp.makeConstraints {
      $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
      $0.centerY.equalTo(leagueLogoImageView)
    }
  }
}
