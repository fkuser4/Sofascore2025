//
//  PeriodCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SnapKit

final class PeriodCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "PeriodCollectionViewCell"
  private let periodView: PeriodView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(periodView)
    periodView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: PeriodViewModel) {
    periodView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    periodView.configure(with: nil)
  }
}
