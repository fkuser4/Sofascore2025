//
//  TeamStatsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
final class TeamStatsViewModel {
  let totalPlayers: String
  let foreignPlayers: String

  init(players: [Player]) {
    let total = players.count
    let foreign = players.filter { $0.isForeign }.count

    self.totalPlayers = "\(total)"
    self.foreignPlayers = "\(foreign)"
  }
}
