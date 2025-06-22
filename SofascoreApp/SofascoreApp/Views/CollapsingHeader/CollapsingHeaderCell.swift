//
//  CollapsingHeaderCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit
import SnapKit

final class CollapsingHeaderCell: UICollectionViewCell {
  static let reuseIdentifier = "CollapsingHeaderCell"
  private let headerView: HeaderView = .init()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: HeaderViewModel) {
    headerView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    headerView.configure(with: nil)
  }
}
