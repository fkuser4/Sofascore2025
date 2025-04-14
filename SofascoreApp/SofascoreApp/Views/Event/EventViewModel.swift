//
//  EventViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import UIKit

class EventViewModel {
  let homeTeamName: String
  let awayTeamName: String

  let homeTeamLogoURL: String
  let awayTeamLogoURL: String

  let homeScore: String
  let awayScore: String

  let homeScoreTextColor: UIColor
  let awayScoreTextColor: UIColor

  let homeTeamTextColor: UIColor
  let awayTeamTextColor: UIColor

  let matchStatusText: String
  let matchStatusTextColor: UIColor

  let matchStartTime: String

  init(event: Event) {
    homeTeamName = event.homeTeam.name
    awayTeamName = event.awayTeam.name

    homeTeamLogoURL = event.homeTeam.logoUrl
    awayTeamLogoURL = event.awayTeam.logoUrl
    homeScore = event.homeScore.map { "\($0)" } ?? ""
    awayScore = event.awayScore.map { "\($0)" } ?? ""

    homeScoreTextColor = Self.scoreTextColor(for: event, isHome: true)
    awayScoreTextColor = Self.scoreTextColor(for: event, isHome: false)

    homeTeamTextColor = Self.teamTextColor(for: event, isHomeTeam: true)
    awayTeamTextColor = Self.teamTextColor(for: event, isHomeTeam: false)

    matchStatusText = Self.formatMatchStatus(from: event)
    matchStatusTextColor = Self.matchStatusTextColor(for: event.status)

    matchStartTime = Self.timestampToHourMinuteString(from: event.startTimestamp)
  }

  private static func timestampToHourMinuteString(from timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
  }

  private static func formatMatchStatus(from event: Event) -> String {
    switch event.status {
    case .finished:
      return "FT"
    case .inProgress:
      let now = Int(Date().timeIntervalSince1970)
      let elapsed = now - event.startTimestamp
      let minutes = elapsed / 60
      return "\(minutes)'"
    case .halftime:
      return "HT"
    case .notStarted:
      return "-"
    }
  }

  private static func matchStatusTextColor(for status: EventStatus) -> UIColor {
    switch status {
    case .inProgress, .halftime:
      return .eventLive
    default:
      return .secondary
    }
  }

  private static func scoreTextColor(for event: Event, isHome: Bool) -> UIColor {
    switch event.status {
    case .inProgress:
      return .eventLive
    case .finished:
      guard let homeScore = event.homeScore, let awayScore = event.awayScore else {
        return .primary
      }
      if homeScore == awayScore {
        return .primary
      }
      let homeWon = homeScore > awayScore
      return (homeWon == isHome) ? .primary : .secondary
    case .notStarted, .halftime:
      return .clear
    }
  }

  private static func teamTextColor(for event: Event, isHomeTeam: Bool) -> UIColor {
    switch event.status {
    case .finished:
      guard let homeScore = event.homeScore, let awayScore = event.awayScore else {
        return .primary
      }
      if homeScore == awayScore {
        return .primary
      }
      let homeWon = homeScore > awayScore
      return (homeWon == isHomeTeam) ? .primary : .secondary
    case .inProgress, .notStarted, .halftime:
      return .primary
    }
  }
}
