//
//  TournamentCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class TournamentCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "TournamentCollectionViewCell"
  private let tournamentView = TournamentView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(tournamentView)
    tournamentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: TournamentViewModel) {
    tournamentView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    tournamentView.configure(with: nil)
  }
}
