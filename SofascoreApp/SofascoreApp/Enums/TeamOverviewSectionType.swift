//
//  TeamOverviewSectionType.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
enum TeamOverviewSectionType {
  case teamInfo
  case stats
  case tournaments
  case venue

  var title: String? {
    switch self {
    case .teamInfo:
      return "Team Info"
    case .stats:
      return nil
    case .tournaments:
      return "Tournaments"
    case .venue:
      return "Venue"
    }
  }

  var hasHeader: Bool {
    return title != nil
  }
}
