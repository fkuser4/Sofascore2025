//
//  EventsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import SofaAcademic

class EventsViewModel {
  private(set) var currentEvents: [League: [Event]] = [:] {
    didSet {
      onCurrentEventsChanged?()
    }
  }

  var displayedLeagues: [League] {
    return currentEvents.keys.sorted { $0.name < $1.name }
  }

  private let dataSource = Homework3DataSource()
  private var eventsMap: [SportType: [League: [Event]]] = [:]
  var onCurrentEventsChanged: (() -> Void)?

  init() {
    setupEventsViewModelMap()
  }

  func selectSport(_ sport: SportType) {
    currentEvents = eventsMap[sport] ?? [:]
  }

  private func getFootballCurrentEvents() -> [League: [Event]] {
    let allEvents = dataSource.events()

    // check if event has league so we can safely force unwrap
    let eventsWithLeague = allEvents.filter { event in
      event.league != nil
    }

    let currentEvents = Dictionary(grouping: eventsWithLeague) { event -> League in
      event.league! // swiftlint:disable:this force_unwrapping
    }

    return currentEvents
  }

  private func getBasketballCurrentEvents() -> [League: [Event]] {
    return [:]
  }

  private func getAmericanFootballCurrentEvents() -> [League: [Event]] {
    return [:]
  }

  private func setupEventsViewModelMap() {
    eventsMap[.football] = getFootballCurrentEvents()
    eventsMap[.basketball] = getBasketballCurrentEvents()
    eventsMap[.americanFootball] = getAmericanFootballCurrentEvents()
  }
}
