//
//  BasketballIncidentCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SnapKit

final class BasketballIncidentCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "BasketballIncidentCollectionViewCell"
  private let basketballIncidentView: BasketballIncidentView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(basketballIncidentView)
    basketballIncidentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: BasketballIncidentViewModel) {
    basketballIncidentView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    basketballIncidentView.configure(with: nil)
  }
}
