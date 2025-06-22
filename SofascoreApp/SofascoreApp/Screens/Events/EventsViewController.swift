//
//  EventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class EventsViewController: BaseLoadableCollectionViewController<EventsViewModel, EventsSectionViewModel> {
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func registerCells() {
    collectionView.register(
      EventCollectionViewCell.self,
      forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)

    collectionView.register(
      LeagueHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: LeagueHeaderCollectionReusableView.reuseIdentifier)

    collectionView.register(
      EventSectionDividerView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: EventSectionDividerView.reuseIdentifier)
  }

  override func configureLayout() {
    collectionView.collectionViewLayout = CompositionalLayoutHelper.createEventsLayout()
  }

  override func handleDataLoaded(_ data: [EventSectionGroup<League>]) {
    dataItems = data.map { sectionGroup in
      let eventViewModels = sectionGroup.events.map { event in
        EventViewModel(event: event)
      }
      return EventsSectionViewModel(
        league: sectionGroup.header,
        eventViewModels: eventViewModels
      )
    }
  }

  private func handleLeagueTap(league: League) {
    let leagueDetailsViewModel = LeagueDetailsViewModel(league: league, sport: viewModel.selectedSport)
    let leagueDetailsVC = LeagueDetailsViewController(viewModel: leagueDetailsViewModel)

    leagueDetailsVC.onDismiss = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }

    navigationController?.pushViewController(leagueDetailsVC, animated: true)
  }
}

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    if kind == UICollectionView.elementKindSectionHeader {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: LeagueHeaderCollectionReusableView.reuseIdentifier,
        for: indexPath
      ) as? LeagueHeaderCollectionReusableView else {
        return UICollectionReusableView()
      }

      let league = dataItems[indexPath.section].league
      headerView.configure(with: LeagueHeaderViewModel(league: league))

      headerView.onTap = { [weak self] tappedLeague in
        self?.handleLeagueTap(league: tappedLeague)
      }

      return headerView
    } else if kind == UICollectionView.elementKindSectionFooter {
      guard let divider = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: EventSectionDividerView.reuseIdentifier,
        for: indexPath
      ) as? EventSectionDividerView else {
        return UICollectionReusableView()
      }

      let isLastSection = indexPath.section == dataItems.count - 1
      divider.configure(lineIsVisible: !isLastSection)

      return divider
    }

    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let eventViewModel = dataItems[indexPath.section].eventViewModels[indexPath.item]

    let eventDetailsViewModel = EventDetailsViewModel(event: eventViewModel.event, sport: viewModel.selectedSport)
    let eventDetailsVC = EventDetailsViewController(viewModel: eventDetailsViewModel)
    eventDetailsVC.onDismiss = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }

    navigationController?.pushViewController(eventDetailsVC, animated: true)
  }
}
