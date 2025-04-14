//
//  EventDetailsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 14.04.2025..
//
import UIKit

class EventDetailsViewModel {
  var matchTime: NSAttributedString
  var matchStatus: NSAttributedString

  var homeTeamName: String
  var awayTeamName: String

  var homeTeamLogoURL: String
  var awayTeamLogoURL: String

  init(event: Event) {
    homeTeamName = event.homeTeam.name
    awayTeamName = event.awayTeam.name

    homeTeamLogoURL = event.homeTeam.logoUrl
    awayTeamLogoURL = event.awayTeam.logoUrl

    matchTime = Self.matchTimeFormatted(event: event)
    matchStatus = Self.matchStatusFormatted(event: event)
  }

  private static func matchTimeFormatted(event: Event) -> NSAttributedString {
    let timeString: String
    let color: UIColor

    switch event.status {
    case .notStarted:
      timeString = formatTimestampToHourMinute(event.startTimestamp)
      color = .primary

    case .inProgress:
      let now = Int(Date().timeIntervalSince1970)
      let elapsed = now - event.startTimestamp
      let minutes = max(elapsed / 60, 0)
      timeString = "\(minutes)'"
      color = .eventLive

    case .halftime:
      timeString = "Halftime"
      color = .secondary

    case .finished:
      timeString = "Full Time"
      color = .secondary
    }

    return NSAttributedString(string: timeString, attributes: [
      .font: UIFont.bodyLight,
      .foregroundColor: color
    ])
  }

  private static func matchStatusFormatted(event: Event) -> NSAttributedString {
    guard let home = event.homeScore, let away = event.awayScore else {
      return NSAttributedString(
        string: formatTimestampToDate(event.startTimestamp),
        attributes: defaultAttributes(color: .primary, font: .bodyLight)
      )
    }

    let scoreString = "\(home) - \(away)"
    let attr = NSMutableAttributedString(string: scoreString)

    switch event.status {
    case .inProgress, .halftime:
      attr.addAttributes(
        defaultAttributes(color: .eventLive, font: .eventDetailScore),
        range: fullRange(of: scoreString)
      )
      return attr

    case .finished:
      return styleFinishedScore(attr, home: home, away: away)

    default:
      return attr
    }
  }

  private static func defaultAttributes(color: UIColor, font: UIFont) -> [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: color,
      .font: font
    ]
  }

  private static func fullRange(of string: String) -> NSRange {
    return NSRange(location: 0, length: string.count)
  }

  private static func formatTimestampToDate(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy."
    return formatter.string(from: date)
  }

  private static func styleFinishedScore(_ attr: NSMutableAttributedString, home: Int, away: Int) -> NSAttributedString {
    let homeStr = "\(home)"
    let sepStr = " - "
    let awayStr = "\(away)"

    let homeRange = NSRange(location: 0, length: homeStr.count)
    let sepRange = NSRange(location: homeStr.count, length: sepStr.count)
    let awayRange = NSRange(location: homeStr.count + sepStr.count, length: awayStr.count)

    attr.addAttributes(defaultAttributes(color: .secondary, font: .eventDetailScore), range: sepRange)

    if home > away {
      attr.addAttributes(defaultAttributes(color: .primary, font: .eventDetailScore), range: homeRange)
      attr.addAttributes(defaultAttributes(color: .secondary, font: .eventDetailScore), range: awayRange)
    } else {
      attr.addAttributes(defaultAttributes(color: .secondary, font: .eventDetailScore), range: homeRange)
      attr.addAttributes(defaultAttributes(color: .primary, font: .eventDetailScore), range: awayRange)
    }

    return attr
  }

  private static func formatTimestampToHourMinute(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
  }
}
