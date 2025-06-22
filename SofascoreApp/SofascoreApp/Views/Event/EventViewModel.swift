//
//  EventViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import UIKit

class EventViewModel {
  let event: Event

  internal let formatter: EventFormatterProtocol
  internal let styleProvider: EventStyleProviderProtocol

  lazy var homeTeamName: String = event.homeTeam.name
  lazy var awayTeamName: String = event.awayTeam.name
  lazy var homeTeamLogoURL: URL? = event.homeTeam.logoUrl.url
  lazy var awayTeamLogoURL: URL? = event.awayTeam.logoUrl.url
  lazy var homeScore: String = event.homeScore.map { "\($0)" } ?? ""
  lazy var awayScore: String = event.awayScore.map { "\($0)" } ?? ""

  lazy var homeScoreTextColor: UIColor = styleProvider.scoreTextColor(for: event, isHome: true)
  lazy var awayScoreTextColor: UIColor = styleProvider.scoreTextColor(for: event, isHome: false)
  lazy var homeTeamTextColor: UIColor = styleProvider.teamTextColor(for: event, isHomeTeam: true)
  lazy var awayTeamTextColor: UIColor = styleProvider.teamTextColor(for: event, isHomeTeam: false)

  lazy var matchStatusText: String = formatter.formatMatchStatus(from: event)
  lazy var matchStatusTextColor: UIColor = styleProvider.matchStatusTextColor(for: event.status)
  lazy var matchStartTime: String = formatter.formatStartTimeHHmm(from: event.startTimestamp)

  init(
    event: Event,
    formatter: EventFormatterProtocol = TimeEventFormatter(),
    styleProvider: EventStyleProviderProtocol = EventStyleProvider()
  ) {
    self.event = event
    self.formatter = formatter
    self.styleProvider = styleProvider
  }
}
