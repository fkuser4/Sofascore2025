//
//  LeagueViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import Foundation

class LeagueHeaderViewModel {
  let league: League

  let leagueName: String
  let countryName: String
  let logoURL: URL?

  init(league: League) {
    self.league = league
    leagueName = league.name
    countryName = league.country.name
    logoURL = league.logoUrl.url
  }
}
