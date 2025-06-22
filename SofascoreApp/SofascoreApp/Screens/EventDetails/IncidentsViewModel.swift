//
//  IncidentsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
import Foundation

final class IncidentsViewModel: BaseLoadableViewModel<[Incident]> {
  private(set) var eventId: Int
  private(set) var sport: SportType
  private(set) var league: League

  init(eventId: Int, sport: SportType, league: League) {
    self.eventId = eventId
    self.sport = sport
    self.league = league
    super.init()
  }

  override func loadData() {
    performLoad { [weak self] completion in
      guard let self = self else { return }

      APIClient.shared.getIncidents(for: self.eventId) { result in
        switch result {
        case .success(let incidents):
          let enriched: [Incident]

          if self.sport == .basketball {
            let chronological = incidents.sorted { $0.minute < $1.minute }
            let enrichedChronological = IncidentScoreHelper.calculateScores(for: chronological)
            enriched = enrichedChronological.sorted { $0.minute > $1.minute }
          } else {
            enriched = incidents.sorted { $0.minute > $1.minute }
          }

          completion(.success(enriched))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
