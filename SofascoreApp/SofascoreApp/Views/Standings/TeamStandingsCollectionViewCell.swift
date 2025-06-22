//
//  TeamStandingsCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import UIKit
import SnapKit

final class TeamStandingsCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "TeamStandingsCollectionViewCell"
  private let teamStandingsView: TeamStandingsView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(teamStandingsView)
    teamStandingsView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: StandingsRowViewModel) {
    teamStandingsView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    teamStandingsView.configure(with: nil)
  }
}
