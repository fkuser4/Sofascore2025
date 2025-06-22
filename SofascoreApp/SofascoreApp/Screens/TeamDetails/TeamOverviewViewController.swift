//
//  TeamOverviewViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class TeamOverviewViewController: BaseLoadableCollectionViewController
<TeamOverviewViewModel, TeamOverviewSectionViewModel> {
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  override func registerCells() {
    collectionView.register(
      ManagerCollectionViewCell.self,
      forCellWithReuseIdentifier: ManagerCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      TeamStatsCollectionViewCell.self,
      forCellWithReuseIdentifier: TeamStatsCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      TournamentCollectionViewCell.self,
      forCellWithReuseIdentifier: TournamentCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      VenueCollectionViewCell.self,
      forCellWithReuseIdentifier: VenueCollectionViewCell.reuseIdentifier
    )

    collectionView.register(
      TeamSectionHeaderCollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: TeamSectionHeaderCollectionReusableView.reuseIdentifier
    )

    collectionView.register(
      TeamSectionFooterView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: TeamSectionFooterView.reuseIdentifier
    )
  }

  override func configureLayout() {
    let layout = CompositionalLayoutHelper.createTeamOverviewLayout()
    layout.register(WhiteBackgroundDecorationView.self, forDecorationViewOfKind: "WhiteBackground")
    collectionView.collectionViewLayout = layout
  }

  override func handleDataLoaded(_ data: TeamOverviewData) {
    var sections: [TeamOverviewSectionViewModel] = []

    sections.append(
      TeamOverviewSectionViewModel(
        type: .teamInfo,
        items: [.manager(ManagerViewModel(manager: data.teamDetails.manager))]
      )
    )

    sections.append(
      TeamOverviewSectionViewModel(
        type: .stats,
        items: [.teamStats(TeamStatsViewModel(players: data.players))]
      )
    )

    let tournamentItems = data.tournaments.map { tournament in
      TeamOverviewCellViewModel.tournament(TournamentViewModel(tournament: tournament))
    }

    sections.append(
      TeamOverviewSectionViewModel(
        type: .tournaments,
        items: tournamentItems
      )
    )

    sections.append(
      TeamOverviewSectionViewModel(
        type: .venue,
        items: [
          .venue(VenueViewModel(venue: data.teamDetails.venue))
        ]
      )
    )

    dataItems = sections
  }
}

extension TeamOverviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataItems.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataItems[section].items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = dataItems[indexPath.section].items[indexPath.item]

    switch item {
    case .manager(let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ManagerCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? ManagerCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    case .teamStats(let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TeamStatsCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? TeamStatsCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    case .tournament(let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TournamentCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? TournamentCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell

    case .venue(let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: VenueCollectionViewCell.reuseIdentifier,
        for: indexPath
      ) as? VenueCollectionViewCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: viewModel)
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TeamSectionHeaderCollectionReusableView.reuseIdentifier,
        for: indexPath
      ) as? TeamSectionHeaderCollectionReusableView else {
        return UICollectionReusableView()
      }

      let sectionType = dataItems[indexPath.section].type
      headerView.configure(with: TeamSectionHeaderViewModel(sectionType: sectionType))
      return headerView
    } else if kind == UICollectionView.elementKindSectionFooter {
      guard let footerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: TeamSectionFooterView.reuseIdentifier,
        for: indexPath
      ) as? TeamSectionFooterView else {
        return UICollectionReusableView()
      }

      footerView.configure()
      return footerView
    }

    return UICollectionReusableView()
  }
}
