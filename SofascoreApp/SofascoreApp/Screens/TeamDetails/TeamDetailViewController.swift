//
//  TeamDetailViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import UIKit

final class TeamDetailsViewController: BaseCollapsingHeaderViewController {
  init(viewModel: TeamDetailsViewModel) {
    let headerVM = Self.makeHeaderViewModel(from: viewModel)
    let pagerTabs = Self.makePagerTabs(from: viewModel)

    super.init(headerViewModel: headerVM, pagerTabs: pagerTabs)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TeamDetailsViewController {
  static func makeHeaderViewModel(from viewModel: TeamDetailsViewModel) -> HeaderViewModel {
    return HeaderViewModel(
      title: viewModel.team.name,
      imageURL: viewModel.team.logoUrl.url,
    )
  }

  static func makePagerTabs(from viewModel: TeamDetailsViewModel) -> [PagerTab] {
    let teamOverviewVM = TeamOverviewViewModel(teamId: viewModel.team.id)
    let squadVM = SquadViewModel(teamId: viewModel.team.id)

    return [
      (title: "Details", controller: TeamOverviewViewController(viewModel: teamOverviewVM)),
      (title: "Squad", controller: SquadViewController(viewModel: squadVM))
    ]
  }
}
