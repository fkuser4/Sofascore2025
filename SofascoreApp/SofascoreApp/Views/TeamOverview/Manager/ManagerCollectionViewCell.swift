//
//  ManagerCollectionViewCell.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class ManagerCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "ManagerCollectionViewCell"
  private let managerView = ManagerView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(managerView)
    managerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: ManagerViewModel) {
    managerView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    managerView.configure(with: nil)
  }
}
