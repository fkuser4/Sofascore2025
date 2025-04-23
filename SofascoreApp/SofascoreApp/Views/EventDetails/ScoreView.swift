//
//  ScoreView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.04.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class ScoreView: BaseView {
  private let homeTeamScoreLabel: UILabel = .init()
  private let awayTeamScoreLabel: UILabel = .init()
  private let seperatorLabel: UILabel = .init()

  func configure(with viewModel: EventDetailsHeaderViewModel) {
    homeTeamScoreLabel.text = viewModel.homeTeamScore
    awayTeamScoreLabel.text = viewModel.awayTeamScore

    homeTeamScoreLabel.textColor = viewModel.homeTeamScoreColor
    awayTeamScoreLabel.textColor = viewModel.awayTeamScoreColor

    seperatorLabel.textColor = viewModel.seperatorColor
  }

  override func addViews() {
    addSubview(homeTeamScoreLabel)
    addSubview(awayTeamScoreLabel)
    addSubview(seperatorLabel)
  }

  override func styleViews() {
    seperatorLabel.text = "-"

    [awayTeamScoreLabel, homeTeamScoreLabel, seperatorLabel].forEach {
      $0.font = .eventDetailHeadline
      $0.lineBreakMode = .byTruncatingTail
      $0.numberOfLines = 1
    }

    seperatorLabel.setContentHuggingPriority(.required, for: .horizontal)
    seperatorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
  }

  override func setupConstraints() {
    seperatorLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.centerX.equalToSuperview()
    }

    homeTeamScoreLabel.snp.makeConstraints { make in
      make.trailing.equalTo(seperatorLabel.snp.leading).offset(-4)
      make.centerY.top.leading.bottom.equalToSuperview()
    }

    awayTeamScoreLabel.snp.makeConstraints { make in
      make.leading.equalTo(seperatorLabel.snp.trailing).offset(4)
      make.centerY.trailing.equalToSuperview()
    }
  }
}
