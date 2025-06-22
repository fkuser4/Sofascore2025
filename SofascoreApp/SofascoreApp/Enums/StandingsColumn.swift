//
//  StandingsColumn.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import Foundation

enum StandingsColumn: String, CaseIterable {
  case matches = "P"
  case wins = "W"
  case draws = "D"
  case losses = "L"
  case goals = "Goals"
  case points = "PTS"
  case pointDiff = "DIFF"
  case streak = "Str"
  case gamesBehind = "GB"
  case percentage = "PCT"

  var title: String { rawValue }

  var width: CGFloat {
    switch self {
    case .matches, .wins, .draws, .losses, .streak:
      return 24
    case .pointDiff, .gamesBehind:
      return 32
    case .percentage, .goals:
      return 40
    case .points:
      return 26
    }
  }

  func value(from entry: StandingsEntry) -> String {
    switch self {
    case .matches: return "\(entry.matches)"
    case .wins: return "\(entry.wins)"
    case .draws: return "\(entry.draws)"
    case .losses: return "\(entry.losses)"
    case .goals: return "\(entry.scoreFor):\(entry.scoreAgainst)"
    case .points: return entry.points.map { "\($0)" } ?? "N/A"
    case .pointDiff:
      return !entry.scoreFormatted.isEmpty
      ? entry.scoreFormatted
    : "\(entry.scoreFor - entry.scoreAgainst)"
    case .streak: return "4"
    case .gamesBehind: return "16.0"
    case .percentage: return entry.percentage.map { String(format: "%.3f", $0) } ?? "N/A"
    }
  }
}
