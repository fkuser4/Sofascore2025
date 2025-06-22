//
//  CollapsingTabBarSupplementaryView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit
import SnapKit

final class TabBarCollectionReuseableView: UICollectionReusableView {
  static let reuseIdentifier = "TabBarCollectionReuseableView"

  let tabBarView = TabBarView()
  var onTabSelected: ((Int) -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(tabBarView)
    tabBarView.snp.makeConstraints { $0.edges.equalToSuperview() }

    tabBarView.onItemSelected = { [weak self] index in
      self?.onTabSelected?(index)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with items: [TabBarItem]) {
    tabBarView.configure(with: items)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    onTabSelected = nil
  }
}
