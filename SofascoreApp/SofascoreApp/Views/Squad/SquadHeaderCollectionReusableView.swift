//
//  SquadHeaderCollectionReusableView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit

final class SquadHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseIdentifier = "SquadHeaderCollectionReusableView"
  private let squadHeader = SquadHeader()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(squadHeader)
    squadHeader .snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func configure(with title: String) {
    squadHeader.configure(title: title)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    squadHeader.configure(title: nil)
  }
}
