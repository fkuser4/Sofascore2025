//
//  VenueCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class VenueCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "VenueCollectionViewCell"
  private let venueView = VenueView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(venueView)
    venueView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: VenueViewModel) {
    venueView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    venueView.configure(with: nil)
  }
}
