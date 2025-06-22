//
//  TeamStandingsHeaderCollectionReusableView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import UIKit

final class StandingsHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseIdentifier = "StandingsHeaderCollectionReusableView"
  private let standingsHeader = StandingsHeader()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(standingsHeader)
    standingsHeader.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    self.backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func configure(with viewModel: StandingsRowViewModel) {
    standingsHeader.configure(with: viewModel)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    standingsHeader.configure(with: nil)
  }
}
