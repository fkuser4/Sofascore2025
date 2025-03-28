//
//  LeagueViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import Foundation
import SofaAcademic

class LeagueHeaderViewModel {
  private let league: League

  init(league: League) {
    self.league = league
  }

  var leagueName: String {
    league.name
  }

  var countryName: String {
    league.country?.name ?? "Unknown"
  }

  var logoURL: URL? {
    return league.logoUrl?.url
  }
}
