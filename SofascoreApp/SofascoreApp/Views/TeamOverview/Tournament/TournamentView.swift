//
//  TournamentView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class TournamentView: BaseView {
  private let tournamentImageView: UIImageView = .init()
  private let tournamentNameLabel: UILabel = .init()

  func configure(with viewModel: TournamentViewModel?) {
    if let viewModel = viewModel {
      tournamentImageView.loadImage(from: viewModel.logoURL)
      tournamentNameLabel.text = viewModel.name
    } else {
      tournamentImageView.image = nil
      tournamentNameLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(tournamentImageView)
    addSubview(tournamentNameLabel)
  }

  override func setupConstraints() {
    tournamentImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(8)
    }

    tournamentNameLabel.snp.makeConstraints { make in
      make.top.equalTo(tournamentImageView.snp.bottom).offset(4)
      make.centerX.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(12)
    }
  }

  override func styleViews() {
    tournamentImageView.image = .icTotalPlayers
    tournamentImageView.contentMode = .scaleAspectFit

    tournamentNameLabel.textColor = .secondary
    tournamentNameLabel.font = .bodyLight
    tournamentNameLabel.textAlignment = .center
  }
}
