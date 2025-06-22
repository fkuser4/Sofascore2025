//
//  FootballIncidentCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SnapKit

final class FootballIncidentCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "FootballIncidentCollectionViewCell"
  private let footballIncidentView: FootballIncidentView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(footballIncidentView)
    footballIncidentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: FootballIncidentViewModel) {
    footballIncidentView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    footballIncidentView.configure(with: nil)
  }
}
