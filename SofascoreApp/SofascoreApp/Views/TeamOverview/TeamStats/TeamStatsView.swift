//
//  TeamStatsView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class TeamStatsView: BaseView {
  private let totalPlayersImageView: UIImageView = .init()
  private let totalPlayersLabel: UILabel = .init()
  private let totalPlayersCountLabel: UILabel = .init()

  private let foreignPlayersProgressCircle: CircularProgressView = .init()
  private let foreignPlayersLabel: UILabel = .init()
  private let foreignPlayersCountLabel: UILabel = .init()


  func configure(with viewModel: TeamStatsViewModel?) {
    if let viewModel = viewModel {
      totalPlayersCountLabel.text = viewModel.totalPlayers
      foreignPlayersCountLabel.text = viewModel.foreignPlayers

      startAnimation(totalPlayers: viewModel.totalPlayers, foreignPlayers: viewModel.foreignPlayers)
    } else {
      totalPlayersCountLabel.text = nil
      foreignPlayersCountLabel.text = nil
      foreignPlayersProgressCircle.resetProgress(animated: false)
    }
  }

  override func addViews() {
    addSubview(totalPlayersImageView)
    addSubview(totalPlayersLabel)
    addSubview(totalPlayersCountLabel)
    addSubview(foreignPlayersProgressCircle)
    addSubview(foreignPlayersLabel)
    addSubview(foreignPlayersCountLabel)
  }

  override func setupConstraints() {
    totalPlayersImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.leading.equalToSuperview().inset(70)
      make.top.equalToSuperview().inset(8)
    }

    totalPlayersCountLabel.snp.makeConstraints { make in
      make.centerX.equalTo(totalPlayersImageView)
      make.top.equalTo(totalPlayersImageView.snp.bottom).offset(8)
    }

    totalPlayersLabel.snp.makeConstraints { make in
      make.centerX.equalTo(totalPlayersImageView)
      make.top.equalTo(totalPlayersCountLabel.snp.bottom).offset(4)
      make.bottom.equalToSuperview().inset(8)
      make.height.equalTo(32)
    }

    foreignPlayersProgressCircle.snp.makeConstraints { make in
      make.size.equalTo(32)
      make.centerY.equalTo(totalPlayersImageView)
      make.trailing.equalToSuperview().inset(70)
    }

    foreignPlayersCountLabel.snp.makeConstraints { make in
      make.centerX.equalTo(foreignPlayersProgressCircle)
      make.centerY.equalTo(totalPlayersCountLabel)
    }

    foreignPlayersLabel.snp.makeConstraints { make in
      make.centerX.equalTo(foreignPlayersProgressCircle)
      make.centerY.equalTo(totalPlayersLabel)
    }
  }

  override func styleViews() {
    totalPlayersLabel.text = "Total Players"
    totalPlayersLabel.font = .bodyLight
    totalPlayersLabel.textAlignment = .center
    totalPlayersLabel.textColor = .secondary

    foreignPlayersLabel.text = "Foreign Players"
    foreignPlayersLabel.font = .bodyLight
    foreignPlayersLabel.textAlignment = .center
    foreignPlayersLabel.textColor = .secondary

    totalPlayersCountLabel.font = .primaryTitle
    totalPlayersCountLabel.textColor = .primaryBackgroundColor

    foreignPlayersCountLabel.font = .primaryTitle
    foreignPlayersCountLabel.textColor = .primaryBackgroundColor

    totalPlayersImageView.image = .icTotalPlayers
    totalPlayersImageView.contentMode = .scaleAspectFit
  }

  private func startAnimation(totalPlayers: String, foreignPlayers: String) {
    if let totalPlayersInt = Int(totalPlayers),
      let foreignPlayersInt = Int(foreignPlayers),
      totalPlayersInt > 0 {
      foreignPlayersProgressCircle.setProgress(
        numerator: CGFloat(foreignPlayersInt),
        denominator: CGFloat(totalPlayersInt),
        animated: true
      )
    }
  }
}
