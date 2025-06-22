//
//  SquadViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
final class SquadViewModel: BaseLoadableViewModel<[Player]> {
  private(set) var teamId: Int

  init(teamId: Int) {
    self.teamId = teamId
    super.init()
  }

  override func loadData() {
    performLoad { [weak self] completion in
      guard let self = self else { return }

      APIClient.shared.getPlayers(forTeam: teamId) { result in
        switch result {
        case .success(let players):
          let sortedPlayers = players.sorted { $0.shortName < $1.shortName }
          completion(.success(sortedPlayers))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
