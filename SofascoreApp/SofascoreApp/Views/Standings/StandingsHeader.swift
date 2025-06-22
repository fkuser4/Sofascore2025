//
//  TeamStandingsHeader.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class StandingsHeader: BaseView {
  private let positionLabel: UILabel = .init()
  private let teamLabel: UILabel = .init()
  private let statsStackView: UIStackView = .init()

  func configure(with viewModel: StandingsRowViewModel?) {
    statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    if let viewModel = viewModel {
      positionLabel.text = viewModel.positionText
      teamLabel.text = viewModel.teamText
      statsStackView.spacing = viewModel.stackSpacing
      setupStatsLabels(statColumns: viewModel.statColumns)
    } else {
      positionLabel.text = nil
      teamLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(positionLabel)
    addSubview(teamLabel)
    addSubview(statsStackView)
  }

  override func setupConstraints() {
    positionLabel.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview().inset(16)
    }

    teamLabel.snp.makeConstraints { make in
      make.centerY.equalTo(positionLabel)
      make.leading.equalTo(positionLabel.snp.trailing).offset(16)
      make.trailing.lessThanOrEqualTo(statsStackView.snp.leading).offset(8)
    }

    statsStackView.snp.makeConstraints { make in
      make.centerY.equalTo(positionLabel)
      make.trailing.equalToSuperview().inset(8)
    }
  }

  override func styleViews() {
    positionLabel.font = .bodyRegular
    positionLabel.textColor = .secondary

    teamLabel.font = .bodyRegular
    teamLabel.textColor = .secondary

    statsStackView.axis = .horizontal
  }

  private func setupStatsLabels(statColumns: [StatColumnInfo]) {
    for info in statColumns {
      let label = UILabel()
      label.text = info.value
      label.font = .bodyRegular
      label.textColor = .secondary
      label.textAlignment = .center
      label.snp.makeConstraints { $0.width.equalTo(info.width) }
      statsStackView.addArrangedSubview(label)
    }
  }
}
