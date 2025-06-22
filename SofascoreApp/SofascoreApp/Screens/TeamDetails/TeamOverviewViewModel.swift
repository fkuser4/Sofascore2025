//
//  TeamOverviewViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import Foundation

final class TeamOverviewViewModel: BaseLoadableViewModel<TeamOverviewData> {
  private(set) var teamId: Int

  init(teamId: Int) {
    self.teamId = teamId
    super.init()
  }

  override func loadData() {
    performLoad { [weak self] completion in
      guard let self = self else { return }

      let group = DispatchGroup()
      var teamDetails: TeamDetails?
      var tournaments: [Tournament] = []
      var players: [Player] = []
      var apiError: APIError?

      self.fetchTeamDetails(group: group) { details, error in
        teamDetails = details
        if let error = error { apiError = error }
      }

      self.fetchTournaments(group: group) { fetchedTournaments, error in
        tournaments = fetchedTournaments
        if apiError == nil, let error = error { apiError = error }
      }

      self.fetchPlayers(group: group) { fetchedPlayers, error in
        players = fetchedPlayers
        if apiError == nil, let error = error { apiError = error }
      }

      group.notify(queue: .main) {
        self.handleAPIResults(
          teamDetails: teamDetails,
          tournaments: tournaments,
          players: players,
          error: apiError,
          completion: completion
        )
      }
    }
  }

  private func fetchTeamDetails(group: DispatchGroup, completion: @escaping (TeamDetails?, APIError?) -> Void) {
    group.enter()
    APIClient.shared.getTeam(by: teamId) { result in
      defer { group.leave() }
      switch result {
      case .success(let details):
        completion(details, nil)
      case .failure(let error):
        completion(nil, error)
      }
    }
  }

  private func fetchTournaments(group: DispatchGroup, completion: @escaping ([Tournament], APIError?) -> Void) {
    group.enter()
    APIClient.shared.getTournaments(forTeam: teamId) { result in
      defer { group.leave() }
      switch result {
      case .success(let tournaments):
        completion(tournaments, nil)
      case .failure(let error):
        completion([], error)
      }
    }
  }

  private func fetchPlayers(group: DispatchGroup, completion: @escaping ([Player], APIError?) -> Void) {
    group.enter()
    APIClient.shared.getPlayers(forTeam: teamId) { result in
      defer { group.leave() }
      switch result {
      case .success(let players):
        completion(players, nil)
      case .failure(let error):
        completion([], error)
      }
    }
  }

  private func handleAPIResults(
    teamDetails: TeamDetails?,
    tournaments: [Tournament],
    players: [Player],
    error: APIError?,
    completion: @escaping (Result<TeamOverviewData, APIError>) -> Void
  ) {
    if let error = error {
      completion(.failure(error))
    } else if let teamDetails = teamDetails {
      let data = TeamOverviewData(
        teamDetails: teamDetails,
        tournaments: tournaments,
        players: players
      )
      completion(.success(data))
    } else {
      completion(.failure(.serverError(status: 0)))
    }
  }
}
