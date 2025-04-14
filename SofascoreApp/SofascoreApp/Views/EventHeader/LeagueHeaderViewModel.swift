//
//  LeagueViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import Foundation

class LeagueHeaderViewModel {
  let leagueName: String
  let countryName: String
  let logoURL: String

  init(league: League) {
    leagueName = league.name
    countryName = league.country.name
    logoURL = league.logoUrl
  }
}
