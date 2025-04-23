//
//  EventsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import UIKit

class EventsViewModel {
  private(set) var currentEvents: [League: [Event]] = [:] {
    didSet {
      onCurrentEventsChanged?()
    }
  }
  private(set) var selectedSport: SportType?
  var displayedLeagues: [League] {
    return currentEvents.keys.sorted { $0.name < $1.name }
  }

  var onCurrentEventsChanged: (() -> Void)?

  func selectSport(_ sport: SportType) {
    selectedSport = sport
    APIClient.shared.getEvents(sportType: sport) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let events):
        var grouped = Dictionary(grouping: events) {
          $0.league
        }

        for (league, events) in grouped {
          grouped[league] = events.sorted {
            $0.startTimestamp < $1.startTimestamp
          }
        }
        DispatchQueue.main.async {
          self.currentEvents = grouped
        }

      case .failure(let error):
        print("Error: \(error.localizedDescription)")
      }
    }
  }
}
