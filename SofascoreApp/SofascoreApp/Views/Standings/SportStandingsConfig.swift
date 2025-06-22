//
//  SportStandingsConfig.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import Foundation

struct SportStandingsConfig {
  let columns: [StandingsColumn]
  let stackSpacing: CGFloat

  static func forSport(_ sport: SportType) -> SportStandingsConfig {
    switch sport {
    case .football:
      return SportStandingsConfig(
        columns: [.matches, .wins, .draws, .losses, .goals, .points],
        stackSpacing: 8
      )
    case .basketball:
      return SportStandingsConfig(
        columns: [.matches, .wins, .losses, .pointDiff, .streak, .gamesBehind, .percentage],
        stackSpacing: 4
      )
    case .americanFootball:
      return SportStandingsConfig(
        columns: [.matches, .wins, .draws, .losses, .percentage],
        stackSpacing: 8
      )
    }
  }
}
