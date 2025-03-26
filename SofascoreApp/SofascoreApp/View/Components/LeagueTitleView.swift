//
//  LeagueTitleView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class LeagueTitleView: BaseView {
  private var countryLabel: UILabel = .init()
  private var leagueNameLabel: UILabel = .init()
  private var arrowImageView: UIImageView = .init()

  func configure(leagueName: String, country: String) {
    countryLabel.text = country
    leagueNameLabel.text = leagueName
    arrowImageView.image = .icPointerRight
  }

  override func addViews() {
    addSubview(countryLabel)
    addSubview(leagueNameLabel)
    addSubview(arrowImageView)
  }

  override func styleViews() {
    countryLabel.font = .primaryTitle
    countryLabel.textColor = .primary
    countryLabel.lineBreakMode = .byTruncatingTail
    countryLabel.setContentHuggingPriority(.required, for: .horizontal)
    countryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

    leagueNameLabel.font = .primaryTitle
    leagueNameLabel.textColor = .secondary
    leagueNameLabel.lineBreakMode = .byTruncatingTail

    arrowImageView.tintColor = .secondary
  }

  override func setupConstraints() {
    countryLabel.snp.makeConstraints {
      $0.leading.height.equalToSuperview()
    }

    arrowImageView.snp.makeConstraints {
      $0.width.equalTo(24)
      $0.leading.equalTo(countryLabel.snp.trailing)
      $0.height.equalToSuperview()
    }

    leagueNameLabel.snp.makeConstraints {
      $0.leading.equalTo(arrowImageView.snp.trailing)
      $0.trailing.height.equalToSuperview()
    }
  }
}
