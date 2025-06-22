//
//  IncidentView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class FootballIncidentView: BaseView {
  private let incidentIconImageView: UIImageView = .init()
  private let minuteLabel: UILabel = .init()
  private let playerLabel: UILabel = .init()
  private let scoreLabel: UILabel = .init()
  private let incidentDescriptionLabel: UILabel = .init()
  private let infoStackView: UIStackView = .init()
  private let cellDividerView: CellDividerView = .init()

  private var isHome: Bool = true

  func configure(with footballIncidentViewModel: FootballIncidentViewModel?) {
    infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    if let footballIncidentViewModel = footballIncidentViewModel {
      incidentIconImageView.image = UIImage(named: footballIncidentViewModel.incidentIcon)
      minuteLabel.text = footballIncidentViewModel.minute
      playerLabel.text = footballIncidentViewModel.player
      scoreLabel.text = footballIncidentViewModel.score
      incidentDescriptionLabel.text = footballIncidentViewModel.description
      isHome = footballIncidentViewModel.isHomeTeam

      if footballIncidentViewModel.type == IncidentType.goal {
        infoStackView.axis = .horizontal
        infoStackView.spacing = 8
        infoStackView.alignment = .center

        if isHome {
          infoStackView.addArrangedSubview(scoreLabel)
          infoStackView.addArrangedSubview(playerLabel)
        } else {
          infoStackView.addArrangedSubview(playerLabel)
          infoStackView.addArrangedSubview(scoreLabel)
        }
      } else {
        infoStackView.axis = .vertical
        infoStackView.alignment = isHome ? .leading : .trailing
        infoStackView.addArrangedSubview(playerLabel)
        infoStackView.addArrangedSubview(incidentDescriptionLabel)
      }

      updateTextAlignment()
      updateLayoutForTeam()
    } else {
      incidentIconImageView.image = nil
      minuteLabel.text = nil
      playerLabel.text = nil
      scoreLabel.text = nil
      incidentDescriptionLabel.text = nil
      isHome = true
    }
  }

  private func updateTextAlignment() {
    if isHome {
      playerLabel.textAlignment = .left
      incidentDescriptionLabel.textAlignment = .left
    } else {
      playerLabel.textAlignment = .right
      incidentDescriptionLabel.textAlignment = .right
    }
  }

  private func updateLayoutForTeam() {
    incidentIconImageView.snp.removeConstraints()
    minuteLabel.snp.removeConstraints()
    cellDividerView.snp.removeConstraints()
    infoStackView.snp.removeConstraints()

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

      infoStackView.snp.makeConstraints { make in
        make.leading.equalTo(cellDividerView.snp.trailing).offset(12)
        make.centerY.equalToSuperview()
        make.trailing.lessThanOrEqualToSuperview().inset(16)
      }

      scoreLabel.snp.makeConstraints { make in
        make.width.equalTo(80)
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

      infoStackView.snp.makeConstraints { make in
        make.trailing.equalTo(cellDividerView.snp.leading).offset(-12)
        make.centerY.equalToSuperview()
        make.leading.greaterThanOrEqualToSuperview().inset(16)
      }
      scoreLabel.snp.makeConstraints { make in
        make.width.equalTo(80)
      }
    }
  }

  override func addViews() {
    addSubview(infoStackView)
    addSubview(cellDividerView)
    addSubview(minuteLabel)
    addSubview(incidentIconImageView)
  }

  override func styleViews() {
    minuteLabel.textAlignment = .center
    minuteLabel.font = .bodyLight
    minuteLabel.textColor = .secondary

    incidentDescriptionLabel.font = .bodyLight
    incidentDescriptionLabel.textColor = .secondary

    playerLabel.font = .bodyRegular
    playerLabel.textColor = .primary

    scoreLabel.font = .screenHeadline
    scoreLabel.textColor = .primary
    scoreLabel.textAlignment = .center

    incidentIconImageView.contentMode = .center
    incidentIconImageView.clipsToBounds = false

    infoStackView.distribution = .fill
  }
}
