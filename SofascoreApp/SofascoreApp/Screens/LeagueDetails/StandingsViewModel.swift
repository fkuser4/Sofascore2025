//
//  StandingsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import Foundation

final class StandingsViewModel: BaseLoadableViewModel<[StandingsEntry]> {
  private(set) var leagueId: Int
  private(set) var sportType: SportType

  init(leagueId: Int, sportType: SportType) {
    self.leagueId = leagueId
    self.sportType = sportType
    super.init()
  }

  override func loadData() {
    performLoad { [weak self] completion in
      guard let self = self else { return }

      APIClient.shared.getStandings(forLeague: self.leagueId) { result in
        switch result {
        case .success(let standings):
          let sortedStandings = standings.sorted {
            $0.position < $1.position
          }
          completion(.success(sortedStandings))

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
