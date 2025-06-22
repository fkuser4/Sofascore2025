//
//  IncidentsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
import SnapKit
import SofaAcademic
import UIKit

class IncidentsViewController: BaseLoadableCollectionViewController<IncidentsViewModel, IncidentViewModel> {
  override var emptyDataView: UIView {
    let emptyIncidentsStateView = EmptyIncidentsStateView()
    emptyIncidentsStateView.didTapDetails = { [weak self] in
      guard let self = self else { return }

      let leagueDetailsViewModel = LeagueDetailsViewModel(league: viewModel.league, sport: viewModel.sport)
      let leagueDetailsVC = LeagueDetailsViewController(viewModel: leagueDetailsViewModel)

      leagueDetailsVC.onDismiss = { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      }
      self.navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }

    return emptyIncidentsStateView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func configureLayout() {
    collectionView.collectionViewLayout = CompositionalLayoutHelper.createIncidentsLayout()
  }

  override func registerCells() {
    collectionView.register(
      PeriodCollectionViewCell.self,
      forCellWithReuseIdentifier: PeriodCollectionViewCell.reuseIdentifier
    )
    collectionView.register(
      FootballIncidentCollectionViewCell.self,
      forCellWithReuseIdentifier: FootballIncidentCollectionViewCell.reuseIdentifier
    )
    collectionView.register(
      BasketballIncidentCollectionViewCell.self,
      forCellWithReuseIdentifier: BasketballIncidentCollectionViewCell.reuseIdentifier
    )
    collectionView.register(
      AmFootballIncidentCollectionViewCell.self,
      forCellWithReuseIdentifier: AmFootballIncidentCollectionViewCell.reuseIdentifier
    )
    collectionView.register(
      TopGradientHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TopGradientHeaderView.reuseIdentifier
    )
  }

  override func handleDataLoaded(_ data: [Incident]) {
    dataItems = data.map { incident in
      IncidentViewModelFactory.makeViewModel(for: incident, sport: viewModel.sport)
    }
  }
}

extension IncidentsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let viewModel = dataItems[indexPath.item]

    switch viewModel {
    case let viewModel as PeriodViewModel:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: PeriodCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? PeriodCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    case let viewModel as FootballIncidentViewModel:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: FootballIncidentCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? FootballIncidentCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    case let viewModel as BasketballIncidentViewModel:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: BasketballIncidentCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? BasketballIncidentCollectionViewCell else {
        return UICollectionViewCell()
      }
      let isLastItem = indexPath.item == dataItems.count - 1
      let isFollowedByPeriod = !isLastItem && (dataItems[indexPath.item + 1] is PeriodViewModel)

      viewModel.showBottomBorder = !(isLastItem || isFollowedByPeriod)

      cell.configure(with: viewModel)
      return cell

    case let viewModel as AmericanFootballIncidentViewModel:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AmFootballIncidentCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? AmFootballIncidentCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    default:
      return UICollectionViewCell()
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0 {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TopGradientHeaderView.reuseIdentifier,
        for: indexPath
      ) as? TopGradientHeaderView else {
        return UICollectionReusableView()
      }
      return headerView
    }

    return UICollectionReusableView()
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let yOffset = scrollView.contentOffset.y

    guard let header = collectionView.supplementaryView(
      forElementKind: UICollectionView.elementKindSectionHeader,
      at: IndexPath(item: 0, section: 0)
    ) as? TopGradientHeaderView else {
      return
    }

    if yOffset < 0 {
      header.applyTransform(CGAffineTransform(translationX: 0, y: yOffset))
    } else {
      header.resetTransform()
    }
  }
}
