//
//  StandingsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import SnapKit
import SofaAcademic
import UIKit

final class StandingsViewController: BaseLoadableCollectionViewController<StandingsViewModel, StandingsRowViewModel> {
  private var headerVM: StandingsRowViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func configureLayout() {
    collectionView.collectionViewLayout = CompositionalLayoutHelper.createStandingsLayout()
  }

  override func registerCells() {
    collectionView.register(
      TeamStandingsCollectionViewCell.self,
      forCellWithReuseIdentifier: TeamStandingsCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      StandingsHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: StandingsHeaderCollectionReusableView.reuseIdentifier
    )
  }

  override func handleDataLoaded(_ data: [StandingsEntry]) {
    let sport = viewModel.sportType
    self.headerVM = StandingsRowViewModel.header(for: sport)
    self.dataItems = data.map {
      StandingsRowViewModel.row(for: $0, sport: sport)
    }
  }
}

extension StandingsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TeamStandingsCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? TeamStandingsCollectionViewCell else {
      return UICollectionViewCell()
    }

    let viewModel = dataItems[indexPath.item]
    cell.configure(with: viewModel)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: StandingsHeaderCollectionReusableView.reuseIdentifier,
        for: indexPath
      ) as? StandingsHeaderCollectionReusableView else {
        return UICollectionReusableView()
      }

      if let headerVM = self.headerVM {
        header.configure(with: headerVM)
        return header
      }

      return UICollectionViewCell()
    }

    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("tap")
    let team = dataItems[indexPath.item].team
    guard let team = team else { return }
    let teamDetailsViewModel = TeamDetailsViewModel(team: team)

    let teamDetailsVC = TeamDetailsViewController(viewModel: teamDetailsViewModel)
    teamDetailsVC.onDismiss = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }

    navigationController?.pushViewController(teamDetailsVC, animated: true)
  }
}
