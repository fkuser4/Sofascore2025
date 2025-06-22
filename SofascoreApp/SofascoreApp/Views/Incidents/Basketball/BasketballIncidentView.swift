//
//  BasketballIncidentView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class BasketballIncidentView: BaseView {
  private let incidentIconImageView: UIImageView = .init()
  private let minuteLabel: UILabel = .init()
  private let cellDividerView: CellDividerView = .init()
  private let scoreLabel: UILabel = .init()
  private let bottomBorderView: UIView = .init()

  private var isHome: Bool = true

  func configure(with basketballIncidentViewModel: BasketballIncidentViewModel?) {
    if let viewModel = basketballIncidentViewModel {
      incidentIconImageView.image = UIImage(named: viewModel.incidentIcon)
      minuteLabel.text = viewModel.minute
      scoreLabel.text = viewModel.score
      isHome = viewModel.isHomeTeam

      bottomBorderView.isHidden = !viewModel.showBottomBorder
    } else {
      incidentIconImageView.image = nil
      minuteLabel.text = nil
      scoreLabel.text = nil
      isHome = true
      bottomBorderView.isHidden = true
    }
    updateLayoutForTeam()
  }

  private func updateLayoutForTeam() {
    incidentIconImageView.snp.removeConstraints()
    cellDividerView.snp.removeConstraints()
    scoreLabel.snp.removeConstraints()

    if isHome {
      incidentIconImageView.snp.makeConstraints { make in
        make.size.equalTo(24)
        make.centerY.equalTo(cellDividerView)
        make.leading.equalToSuperview().inset(16)
      }

      cellDividerView.snp.makeConstraints { make in
        make.leading.equalTo(incidentIconImageView.snp.trailing).offset(15)
        make.top.bottom.equalToSuperview().inset(8)
        make.width.equalTo(1)
      }

      scoreLabel.snp.makeConstraints { make in
        make.centerY.equalTo(incidentIconImageView)
        make.leading.equalTo(cellDividerView.snp.trailing).offset(4)
        make.trailing.equalTo(minuteLabel.snp.leading).offset(-28)
      }
    } else {
      incidentIconImageView.snp.makeConstraints { make in
        make.size.equalTo(24)
        make.centerY.equalTo(cellDividerView)
        make.trailing.equalToSuperview().inset(16)
      }

      cellDividerView.snp.makeConstraints { make in
        make.trailing.equalTo(incidentIconImageView.snp.leading).offset(-15)
        make.top.bottom.equalToSuperview().inset(8)
        make.width.equalTo(1)
      }

      scoreLabel.snp.makeConstraints { make in
        make.centerY.equalTo(incidentIconImageView)
        make.trailing.equalTo(cellDividerView.snp.leading).offset(-4)
        make.leading.equalTo(minuteLabel.snp.trailing).offset(28)
      }
    }
  }

  override func addViews() {
    addSubview(incidentIconImageView)
    addSubview(cellDividerView)
    addSubview(scoreLabel)
    addSubview(minuteLabel)
    addSubview(bottomBorderView)
  }

  override func setupConstraints() {
    minuteLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    bottomBorderView.snp.makeConstraints { make in
      make.width.equalTo(24)
      make.height.equalTo(1)
      make.centerX.equalToSuperview()

      make.bottom.equalToSuperview()
    }

    updateLayoutForTeam()
  }

  override func styleViews() {
    incidentIconImageView.contentMode = .center
    incidentIconImageView.clipsToBounds = false

    scoreLabel.textAlignment = .center
    scoreLabel.font = .primaryTitle
    scoreLabel.textColor = .primary

    minuteLabel.textAlignment = .center
    minuteLabel.font = .bodyLight
    minuteLabel.textColor = .secondary

    bottomBorderView.backgroundColor = .secondary
    bottomBorderView.isHidden = true
  }
}
