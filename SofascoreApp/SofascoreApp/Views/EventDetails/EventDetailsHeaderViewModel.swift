//
//  EventDetailsHeaderViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 14.04.2025..
//
import UIKit

class EventDetailsHeaderViewModel {
  var matchTime: String
  var matchTimeColor: UIColor

  var homeTeamName: String
  var awayTeamName: String

  var homeTeamScore: String
  var homeTeamScoreColor: UIColor

  var awayTeamScore: String
  var awayTeamScoreColor: UIColor

  var seperatorColor: UIColor

  var homeTeamLogoURL: URL?
  var awayTeamLogoURL: URL?

  var scoreAvailable: Bool

  var matchStartDate: String

  init(event: Event) {
    homeTeamName = event.homeTeam.name
    awayTeamName = event.awayTeam.name

    homeTeamLogoURL = event.homeTeam.logoUrl.url
    awayTeamLogoURL = event.awayTeam.logoUrl.url

    homeTeamName = event.homeTeam.name
    homeTeamScore = "\(event.homeScore ?? 0)"
    awayTeamName = event.awayTeam.name
    awayTeamScore = "\(event.awayScore ?? 0)"

    homeTeamScoreColor = Self.homeTeamScoreColor(event: event)
    awayTeamScoreColor = Self.awayTeamScoreColor(event: event)
    seperatorColor = Self.seperatorColor(event: event)

    matchTime = Self.matchTimeFormatted(event: event)
    matchTimeColor = Self.matchTimeColor(event: event)

    scoreAvailable = event.awayScore != nil && event.homeScore != nil
    matchStartDate = Self.formatTimestampToDate(event.startTimestamp)
  }

  private static func matchTimeFormatted(event: Event) -> String {
    switch event.status {
    case .notStarted:
      return formatTimestampToHourMinute(event.startTimestamp)
    case .inProgress:
      let now = Int(Date().timeIntervalSince1970)
      let elapsed = now - event.startTimestamp
      let minutes = max(elapsed / 60, 0)
      return "\(minutes)'"
    case .halftime:
      return "Halftime"
    case .finished:
      return "Full Time"
    }
  }

  private static func matchTimeColor(event: Event) -> UIColor {
    switch event.status {
    case .notStarted:
      return .primary
    case .inProgress:
      return .eventLive
    case .halftime, .finished:
      return .secondary
    }
  }

  private static func formatTimestampToDate(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy."
    return formatter.string(from: date)
  }

  private static func formatTimestampToHourMinute(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
  }

  private static func homeTeamScoreColor(event: Event) -> UIColor {
    switch event.status {
    case .inProgress, .halftime:
      return .eventLive
    case .finished:
      guard let homeScore = event.homeScore, let awayScore = event.awayScore else {
        return .secondary
      }
      return homeScore > awayScore ? .primary : .secondary
    default:
      return .secondary
    }
  }

  private static func awayTeamScoreColor(event: Event) -> UIColor {
    switch event.status {
    case .inProgress, .halftime:
      return .eventLive
    case .finished:
      guard let homeScore = event.homeScore, let awayScore = event.awayScore else {
        return .secondary
      }
      return awayScore > homeScore ? .primary : .secondary
    default:
      return .secondary
    }
  }

  private static func seperatorColor(event: Event) -> UIColor {
    switch event.status {
    case .inProgress, .halftime:
      return .eventLive
    default:
      return .secondary
    }
  }
}
