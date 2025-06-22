//
//  AmericanFootballView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class AmericanFootballIncidentView: BaseView {
  private let incidentIconImageView: UIImageView = .init()
  private let minuteLabel: UILabel = .init()
  private let playerLabel: UILabel = .init()
  private let scoreLabel: UILabel = .init()
  private let cellDividerView: CellDividerView = .init()

  private var isHome: Bool = true


  func configure(with americanFootballIncidentViewModel: AmericanFootballIncidentViewModel?) {
    if let americanFootballIncidentViewModel = americanFootballIncidentViewModel {
      incidentIconImageView.image = UIImage(named: americanFootballIncidentViewModel.incidentIcon)
      minuteLabel.text = americanFootballIncidentViewModel.minute
      playerLabel.text = americanFootballIncidentViewModel.player
      scoreLabel.text = americanFootballIncidentViewModel.score
      isHome = americanFootballIncidentViewModel.isHomeTeam

      updateLayoutForTeam()
    } else {
      incidentIconImageView.image = nil
      minuteLabel.text = nil
      playerLabel.text = nil
      scoreLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(incidentIconImageView)
    addSubview(minuteLabel)
    addSubview(playerLabel)
    addSubview(scoreLabel)
    addSubview(cellDividerView)
  }

  private func updateLayoutForTeam() {
    incidentIconImageView.snp.removeConstraints()
    minuteLabel.snp.removeConstraints()
    cellDividerView.snp.removeConstraints()
    playerLabel.snp.removeConstraints()
    scoreLabel.snp.removeConstraints()

    if isHome {
      incidentIconImageView.snp.makeConstraints { make in
        make.size.equalTo(24)
        make.leading.equalToSuperview().inset(16)
        make.top.equalToSuperview().inset(8)
      }

      minuteLabel.snp.makeConstraints { make in
        make.top.equalTo(incidentIconImageView.snp.bottom)
        make.centerX.equalTo(incidentIconImageView)
        make.bottom.equalToSuperview().inset(8)
        make.leading.lessThanOrEqualToSuperview().inset(8)
        make.trailing.lessThanOrEqualTo(cellDividerView.snp.leading).offset(-7)
      }

      cellDividerView.snp.makeConstraints { make in
        make.leading.equalTo(incidentIconImageView.snp.trailing).offset(15)
        make.top.bottom.equalToSuperview().inset(8)
      }

      scoreLabel.snp.makeConstraints { make in
        make.width.equalTo(84)
        make.centerY.equalToSuperview()
        make.leading.equalTo(cellDividerView.snp.trailing).offset(8)
      }

      playerLabel.snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.leading.equalTo(scoreLabel.snp.trailing).offset(8)
        make.trailing.lessThanOrEqualToSuperview()
      }
    } else {
      incidentIconImageView.snp.makeConstraints { make in
        make.size.equalTo(24)
        make.trailing.equalToSuperview().inset(16)
        make.top.equalToSuperview().inset(8)
      }

      minuteLabel.snp.makeConstraints { make in
        make.top.equalTo(incidentIconImageView.snp.bottom)
        make.centerX.equalTo(incidentIconImageView)
        make.bottom.equalToSuperview().inset(8)
        make.trailing.lessThanOrEqualToSuperview().inset(8)
        make.leading.lessThanOrEqualTo(cellDividerView.snp.trailing).offset(7)
      }

      cellDividerView.snp.makeConstraints { make in
        make.trailing.equalTo(incidentIconImageView.snp.leading).offset(-15)
        make.top.bottom.equalToSuperview().inset(8)
      }

      scoreLabel.snp.makeConstraints { make in
        make.width.equalTo(84)
        make.centerY.equalToSuperview()
        make.trailing.equalTo(cellDividerView.snp.leading).offset(-8)
      }

      playerLabel.snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.trailing.equalTo(scoreLabel.snp.leading).offset(-8)
        make.leading.greaterThanOrEqualToSuperview().inset(8)
      }
    }
  }


override func styleViews() {
  minuteLabel.textAlignment = .center
  minuteLabel.font = .bodyLight
  minuteLabel.textColor = .secondary

  playerLabel.font = .bodyRegular
  playerLabel.textColor = .primary

  scoreLabel.font = .screenHeadline
  scoreLabel.textColor = .primary
  scoreLabel.textAlignment = .center

  incidentIconImageView.contentMode = .center
  incidentIconImageView.clipsToBounds = false
}
}
