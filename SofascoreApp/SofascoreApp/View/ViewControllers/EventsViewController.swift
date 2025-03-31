//
//  EventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class EventsViewController: UIViewController {
  private let viewModel: MainViewModel
  private var collectionView: UICollectionView!

  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    let layout = createCompositionalLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white

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

    setupSubviews()
    setupConstraints()
    setupBinding()
  }

  private func setupBinding() {
    viewModel.bindToData = { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if self.viewModel.leagues.isEmpty {
          self.collectionView.backgroundView = EmptyStateView(message: "No events available for this sport.")
        } else {
          self.collectionView.backgroundView = nil
        }
        UIView.performWithoutAnimation {
          self.collectionView.reloadData()
        }
      }
    }
  }

  private func setupSubviews() {
    view.addSubview(collectionView)
  }

  private func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { _, _ in
      return CompositionalLayoutHelper.createPinnedHeaderListSectionWithFooter()
    }
  }
}

extension EventsViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.leagues.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let league = viewModel.leagues[section]
    return viewModel.events(for: league).count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
      for: indexPath
    ) as? EventCollectionViewCell else {
      return UICollectionViewCell()
    }

    let league = viewModel.leagues[indexPath.section]
    let events = viewModel.events(for: league)
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

      let league = viewModel.leagues[indexPath.section]
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
}
