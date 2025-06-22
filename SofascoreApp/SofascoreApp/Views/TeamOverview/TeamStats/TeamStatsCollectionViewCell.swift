//
//  TeamStatsCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class TeamStatsCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "TeamStatsCollectionViewCell"
  private let teamStatsView = TeamStatsView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(teamStatsView)
    teamStatsView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: TeamStatsViewModel) {
    teamStatsView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    teamStatsView.configure(with: nil)
  }
}
