//
//  RoundHeaderCollectionReusableView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import UIKit
import SnapKit

final class MatchesHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseIdentifier = "MatchesHeaderCollectionReusableView"
  private let matchHeaderView = MatchHeader()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(matchHeaderView)
    matchHeaderView .snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func configure(with title: String) {
    matchHeaderView.configure(title: title)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    matchHeaderView.configure(title: nil)
  }
}
