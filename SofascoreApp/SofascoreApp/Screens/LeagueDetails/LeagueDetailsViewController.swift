//
//  LeagueDetailsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit

final class LeagueDetailsViewController: BaseCollapsingHeaderViewController {
  init(viewModel: LeagueDetailsViewModel) {
    let headerVM = Self.makeHeaderViewModel(from: viewModel)
    let pagerTabs = Self.makePagerTabs(from: viewModel)

    super.init(headerViewModel: headerVM, pagerTabs: pagerTabs)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension LeagueDetailsViewController {
  static func makeHeaderViewModel(from viewModel: LeagueDetailsViewModel) -> HeaderViewModel {
    return HeaderViewModel(
      title: viewModel.league.name,
      imageURL: viewModel.league.logoUrl.url,
      country: viewModel.league.country.name
    )
  }

  static func makePagerTabs(from viewModel: LeagueDetailsViewModel) -> [PagerTab] {
    let matchesVM = MatchesViewModel(
      leagueId: viewModel.league.id,
      sportType: viewModel.sport
    )

    let standingsVM = StandingsViewModel(
      leagueId: viewModel.league.id,
      sportType: viewModel.sport
    )

    return [
      (title: "Matches", controller: MatchesViewController(viewModel: matchesVM)),
      (title: "Standings", controller: StandingsViewController(viewModel: standingsVM))
    ]
  }
}
