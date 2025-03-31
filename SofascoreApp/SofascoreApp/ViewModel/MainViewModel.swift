//
//  MainViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 31.03.2025..
//
import SofaAcademic

class MainViewModel {
  public var bindToData: (() -> Void)?

  private var allEvents: [Event] = [] {
    didSet { bindToData?() }
  }

  private var currentEvents: [League: [Event]] = [:] {
    didSet { bindToData?() }
  }

  private var displayedLeagues: [League] = [] {
    didSet { bindToData?() }
  }

  private let dataSource = Homework3DataSource()

  public func tabChange(to: SportType) {
    switch to {
    case .football:
      setFootballEvents()
    case .basketball:
      setBasketballEvents()
    case .americanFootball:
      setAmericanFootballEvents()
    }
  }

  public var leagues: [League] {
    return displayedLeagues
  }

  public func events(for league: League) -> [Event] {
    return currentEvents[league] ?? []
  }

  private func setFootballEvents() {
    allEvents = dataSource.events()
    currentEvents = [:]
    displayedLeagues = []

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
  }

  private func setBasketballEvents() {
    allEvents = []
    currentEvents = [:]
    displayedLeagues = []
  }

  private func setAmericanFootballEvents() {
    allEvents = []
    currentEvents = [:]
    displayedLeagues = []
  }
}
