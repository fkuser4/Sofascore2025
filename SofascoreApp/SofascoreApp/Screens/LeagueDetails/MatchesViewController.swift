//
//  MatchesViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit

final class MatchesViewController: BaseLoadableCollectionViewController<MatchesViewModel, MatchesSectionViewModel> {
  private let eventFormatter = DateEventFormatter()

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
  }

  override func configureLayout() {
    collectionView.collectionViewLayout = CompositionalLayoutHelper.createMatchesLayout()
  }

  override func registerCells() {
    collectionView.register(
      EventCollectionViewCell.self,
      forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier
    )
    collectionView.register(
      MatchesHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: MatchesHeaderCollectionReusableView.reuseIdentifier
    )
  }

  override func handleDataLoaded(_ data: [EventSectionGroup<String>]) {
    dataItems = data.map { sectionGroup in
      let eventViewModels = sectionGroup.events.map { event in
        EventViewModel(event: event, formatter: eventFormatter)
      }
      return MatchesSectionViewModel(
        headerTitle: sectionGroup.header,
        eventViewModels: eventViewModels
      )
    }
  }
}

extension MatchesViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataItems.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataItems[section].eventViewModels.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? EventCollectionViewCell else {
      return UICollectionViewCell()
    }

    let eventViewModel = dataItems[indexPath.section].eventViewModels[indexPath.item]
    cell.configure(with: eventViewModel)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: MatchesHeaderCollectionReusableView.reuseIdentifier,
      for: indexPath
    ) as? MatchesHeaderCollectionReusableView else {
      return UICollectionReusableView()
    }

    let headerTitle = dataItems[indexPath.section].headerTitle
    headerView.configure(with: headerTitle)
    return headerView
  }
}
