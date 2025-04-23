//
//  EventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class EventsViewController: UIViewController, BaseViewProtocol {
  private let viewModel: EventsViewModel
  private let emptyStateView = EmptyStateView()

  private lazy var collectionView: UICollectionView = {
    let layout = createCompositionalLayout()
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()

  init(viewModel: EventsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)

    viewModel.onCurrentEventsChanged = { [weak self] in
      guard let self = self else { return }
      self.collectionView.backgroundView?.isHidden = !self.viewModel.currentEvents.isEmpty
      self.collectionView.reloadData()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupCollectionView()
    addViews()
    styleViews()
    setupConstraints()

    collectionView.backgroundView?.isHidden = !viewModel.currentEvents.isEmpty
    collectionView.reloadData()
  }

  func addViews() {
    view.addSubview(collectionView)
    collectionView.backgroundView = emptyStateView
  }

  func styleViews() {
    collectionView.backgroundColor = .white
    emptyStateView.setMessageText("No events available for this sport.")
  }

  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private func setupCollectionView() {
    collectionView.register(
      EventCollectionViewCell.self,
      forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)

    collectionView.register(
      LeagueHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: LeagueHeaderCollectionReusableView.reuseIdentifier)

    collectionView.register(
      SectionDividerView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: SectionDividerView.reuseIdentifier)

    collectionView.dataSource = self
    collectionView.delegate = self
  }

  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { _, _ in
      return CompositionalLayoutHelper.createPinnedHeaderListSectionWithFooter()
    }
  }
}

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.displayedLeagues.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let league = viewModel.displayedLeagues[section]
    return viewModel.currentEvents[league]?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? EventCollectionViewCell else {
      return UICollectionViewCell()
    }

    let league = viewModel.displayedLeagues[indexPath.section]

    guard let events = viewModel.currentEvents[league], indexPath.item < events.count else {
      return cell
    }

    let event = events[indexPath.item]
    cell.configure(with: EventViewModel(event: event))
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

      let league = viewModel.displayedLeagues[indexPath.section]
      headerView.configure(with: LeagueHeaderViewModel(league: league))
      return headerView
    } else if kind == UICollectionView.elementKindSectionFooter {
      guard let divider = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: SectionDividerView.reuseIdentifier,
        for: indexPath
      ) as? SectionDividerView else {
        return UICollectionReusableView()
      }
      return divider
    }

    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let league = viewModel.displayedLeagues[indexPath.section]
    guard let events = viewModel.currentEvents[league], indexPath.item < events.count else {
      return
    }
    let event = events[indexPath.item]

    let eventDetailsVC: EventDetailsViewController = .init()
    eventDetailsVC.event = event
    eventDetailsVC.sport = viewModel.selectedSport?.title ?? ""
    eventDetailsVC.onDismiss = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
    navigationController?.pushViewController(eventDetailsVC, animated: true)

    print("item at \(indexPath.section)/\(indexPath.item) tapped")
  }
}
