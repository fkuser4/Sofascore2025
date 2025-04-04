//
//  MainViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 31.03.2025..
//
import SofaAcademic

class MainViewModel {
  private let dataSource = Homework3DataSource()
  private var eventsViewModelMap: [SportType: EventsViewModel] = [:]

  init() {
    setupEventsViewModelMap()
  }

  public func eventsViewModel(for sportType: SportType) -> EventsViewModel? {
    return eventsViewModelMap[sportType]
  }

  private func getFootballEventsViewModel() -> EventsViewModel {
    let allEvents = dataSource.events()
    var currentEvents: [League: [Event]] = [:]
    var displayedLeagues: [League] = []

    for event in allEvents {
      guard let league = event.league else { continue }
      if var leagueEvents = currentEvents[league] {
        leagueEvents.append(event)
        currentEvents[league] = leagueEvents
      } else {
        currentEvents[league] = [event]
        displayedLeagues.append(league)
      }
    }

    displayedLeagues.sort { $0.name < $1.name }

    return EventsViewModel(currentEvents: currentEvents, displayedLeagues: displayedLeagues)
  }

  private func getBasketballEventsViewModel() -> EventsViewModel {
    return EventsViewModel(currentEvents: [:], displayedLeagues: [])
  }

  private func getAmericanFootballEventsViewModel() -> EventsViewModel {
    return EventsViewModel(currentEvents: [:], displayedLeagues: [])
  }

  private func setupEventsViewModelMap() {
    eventsViewModelMap[.football] = getFootballEventsViewModel()
    eventsViewModelMap[.basketball] = getBasketballEventsViewModel()
    eventsViewModelMap[.americanFootball] = getAmericanFootballEventsViewModel()
  }
}
