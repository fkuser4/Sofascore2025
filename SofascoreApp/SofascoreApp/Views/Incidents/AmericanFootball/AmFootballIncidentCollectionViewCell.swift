//
//  AmericanFootball.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SnapKit

final class AmFootballIncidentCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "AmFootballIncidentCollectionViewCell"
  private let americanFootballIncidentView: AmericanFootballIncidentView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(americanFootballIncidentView)
    americanFootballIncidentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: AmericanFootballIncidentViewModel) {
    americanFootballIncidentView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    americanFootballIncidentView.configure(with: nil)
  }
}
