//
//  TopGradientHeaderView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
import UIKit
import SnapKit

class TopGradientHeaderView: UICollectionReusableView {
  static let reuseIdentifier = "TopGradientHeaderView"
  private let gradientSeparatorView = GradientSeparatorView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(gradientSeparatorView)
    gradientSeparatorView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func resetTransform() {
    gradientSeparatorView.transform = .identity
  }

  func applyTransform(_ transform: CGAffineTransform) {
    gradientSeparatorView.transform = transform
  }
}
