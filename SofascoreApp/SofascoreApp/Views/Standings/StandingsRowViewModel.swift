//
//  StandingsRowViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import Foundation

final class StandingsRowViewModel {
  let positionText: String
  let teamText: String
  let statColumns: [StatColumnInfo]
  let stackSpacing: CGFloat
  let team: Team?

  init(positionText: String, teamText: String, statColumns: [StatColumnInfo], stackSpacing: CGFloat, team: Team? = nil) {
    self.positionText = positionText
    self.teamText = teamText
    self.statColumns = statColumns
    self.stackSpacing = stackSpacing
    self.team = team
  }

  static func header(for sport: SportType) -> StandingsRowViewModel {
    let config = SportStandingsConfig.forSport(sport)
    let stats = config.columns.map {
      StatColumnInfo(value: $0.title, width: $0.width)
    }
    return StandingsRowViewModel(
      positionText: "#",
      teamText: "Team",
      statColumns: stats,
      stackSpacing: config.stackSpacing
    )
  }

  static func row(for entry: StandingsEntry, sport: SportType) -> StandingsRowViewModel {
    let config = SportStandingsConfig.forSport(sport)
    let stats = config.columns.map {
      StatColumnInfo(value: $0.value(from: entry), width: $0.width)
    }
    return StandingsRowViewModel(
      positionText: "\(entry.position)",
      teamText: entry.team.name,
      statColumns: stats,
      stackSpacing: config.stackSpacing,
      team: entry.team
    )
  }
}
