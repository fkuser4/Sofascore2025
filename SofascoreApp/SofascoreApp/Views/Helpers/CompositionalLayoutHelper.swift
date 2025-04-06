//
//  CompositionalLayoutHelper.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 31.03.2025..
//
import UIKit

enum CompositionalLayoutHelper {
  static func createPinnedHeaderListSectionWithFooter(
    itemEstimatedHeight: CGFloat = 56,
    groupEstimatedHeight: CGFloat = 56,
    headerEstimatedHeight: CGFloat = 56,
    footerEstimatedHeight: CGFloat = 8
  ) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(itemEstimatedHeight))

    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(groupEstimatedHeight))

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)

    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(headerEstimatedHeight))

    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)

    header.pinToVisibleBounds = true

    let footerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(footerEstimatedHeight))

    let footer = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: footerSize,
      elementKind: UICollectionView.elementKindSectionFooter,
      alignment: .bottom)

    section.boundarySupplementaryItems = [header, footer]

    return section
  }
}
