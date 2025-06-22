//
//  SquadViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SnapKit
import SofaAcademic
import UIKit

final class SquadViewController: BaseLoadableCollectionViewController<SquadViewModel, PlayerViewModel> {
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func configureLayout() {
    collectionView.collectionViewLayout = CompositionalLayoutHelper.createSquadLayout()
  }

  override func registerCells() {
    collectionView.register(
      PlayerCollectionViewCell.self,
      forCellWithReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      SquadHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: SquadHeaderCollectionReusableView.reuseIdentifier
    )
  }

  override func handleDataLoaded(_ data: [Player]) {
    dataItems = data.map { player in
      PlayerViewModel(player: player)
    }
  }
}

extension SquadViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataItems.isEmpty ? 0 : 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PlayerCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? PlayerCollectionViewCell else {
      return UICollectionViewCell()
    }
    let viewModel = dataItems[indexPath.item]

    let isLast = indexPath.item == dataItems.count - 1

    cell.configure(with: viewModel, isLast: isLast)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0 {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SquadHeaderCollectionReusableView.reuseIdentifier,
        for: indexPath
      ) as? SquadHeaderCollectionReusableView else {
        return UICollectionReusableView()
      }

      headerView.configure(with: "Players")
      return headerView
    }

    return UICollectionReusableView()
  }
}
