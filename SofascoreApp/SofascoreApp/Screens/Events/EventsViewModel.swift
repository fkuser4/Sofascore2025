//
//  EventsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import UIKit

final class EventsViewModel: BaseLoadableViewModel<[EventSectionGroup<League>]> {
  private(set) var selectedSport: SportType

  func selectSport(_ sport: SportType) {
    self.selectedSport = sport
    loadData()
  }

  init(initialSport: SportType) {
    self.selectedSport = initialSport
  }

  override func loadData() {
    performLoad { completion in
      APIClient.shared.getEvents(sportType: self.selectedSport) { result in
        switch result {
        case .success(let events):
          let groupedByLeague = Dictionary(grouping: events) { $0.league }

          let sections = groupedByLeague.map { league, events -> EventSectionGroup<League> in
            let sortedEvents = events.sorted { $0.startTimestamp < $1.startTimestamp }
            return EventSectionGroup<League>(header: league, events: sortedEvents)
          }

          let sortedSections = sections.sorted { $0.header.name < $1.header.name }
          completion(.success(sortedSections))

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
