//
//  TeamSectionHeaderCollectionReusableView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class TeamSectionHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseIdentifier = "TeamSectionHeaderCollectionReusableView"
  private let headerView = TeamSectionHeaderView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: TeamSectionHeaderViewModel) {
    headerView.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    headerView.configure(with: nil)
  }
}
