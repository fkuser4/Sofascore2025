//
//  EventStyleProvider.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import UIKit

struct EventStyleProvider: EventStyleProviderProtocol {
  func scoreTextColor(for event: Event, isHome: Bool) -> UIColor {
    switch event.status {
    case .inProgress: return .eventLive
    case .finished:
      guard let homeScore = event.homeScore,
        let awayScore = event.awayScore else { return .primary }
      if homeScore == awayScore { return .primary }
      let homeWon = homeScore > awayScore
      return (homeWon == isHome) ? .primary : .secondary
    case .notStarted, .halftime: return .clear
    }
  }

  func teamTextColor(for event: Event, isHomeTeam: Bool) -> UIColor {
    switch event.status {
    case .finished:
      guard let homeScore = event.homeScore,
        let awayScore = event.awayScore else { return .primary }
      if homeScore == awayScore { return .primary }
      let homeWon = homeScore > awayScore
      return (homeWon == isHomeTeam) ? .primary : .secondary
    case .inProgress, .notStarted, .halftime: return .primary
    }
  }

  func matchStatusTextColor(for status: EventStatus) -> UIColor {
    switch status {
    case .inProgress, .halftime: return .eventLive
    default: return .secondary
    }
  }
}
