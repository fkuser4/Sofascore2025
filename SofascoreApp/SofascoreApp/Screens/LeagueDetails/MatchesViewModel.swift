//
//  MatchesViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
//
//  MatchesViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit

final class MatchesViewModel: BaseLoadableViewModel<[EventSectionGroup<String>]> {
  private let leagueId: Int
  private let sportType: SportType?

  init(leagueId: Int, sportType: SportType?) {
    self.sportType = sportType
    self.leagueId = leagueId
  }

  override func loadData() {
    guard let sport = sportType else { return }

    performLoad { completion in
      APIClient.shared.getEvents(forLeague: self.leagueId) { result in
        switch result {
        case .success(let events):
          let sections = self.createSections(for: sport, with: events)
          completion(.success(sections))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  private func createSections(for sport: SportType, with events: [Event]) -> [EventSectionGroup<String>] {
    if sport == .basketball {
      return createBasketballSections(from: events)
    } else {
      return createRoundSections(from: events)
    }
  }

  private func createBasketballSections(from events: [Event]) -> [EventSectionGroup<String>] {
    let groupedByLabel = Dictionary(grouping: events) { event -> String in
      self.labelForBasketballEvent(event)
    }

    let sections = groupedByLabel.map { label, events in
      let sortedEvents = events.sorted { $0.startTimestamp < $1.startTimestamp }
      return EventSectionGroup(header: label, events: sortedEvents)
    }

    return sections.sorted { lhs, rhs in
      self.compareSectionTitles(lhs.header, rhs.header)
    }
  }

  private func createRoundSections(from events: [Event]) -> [EventSectionGroup<String>] {
    let groupedByRound = Dictionary(grouping: events) { "Round \($0.round)" }

    let sections = groupedByRound.map { round, events in
      let sortedEvents = events.sorted { $0.startTimestamp < $1.startTimestamp }
      return EventSectionGroup(header: round, events: sortedEvents)
    }

    return sections.sorted { $0.header < $1.header }
  }

  private func labelForBasketballEvent(_ event: Event) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
    let calendar = Calendar.current

    if calendar.isDateInToday(date) {
      return "Today"
    } else if calendar.isDateInTomorrow(date) {
      return "Tomorrow"
    } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
      let weekdayFormatter = DateFormatter()
      weekdayFormatter.dateFormat = "EEE"
      return weekdayFormatter.string(from: date)
    } else {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd.MM.yy."
      return dateFormatter.string(from: date)
    }
  }

  private func compareSectionTitles(_ lhs: String, _ rhs: String) -> Bool {
    let order = ["Today", "Tomorrow", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let lhsIndex = order.firstIndex(of: lhs) ?? Int.max
    let rhsIndex = order.firstIndex(of: rhs) ?? Int.max

    if lhsIndex != rhsIndex {
      return lhsIndex < rhsIndex
    } else {
      return lhs < rhs
    }
  }
}
