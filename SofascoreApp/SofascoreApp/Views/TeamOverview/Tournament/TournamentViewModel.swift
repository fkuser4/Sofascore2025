//
//  TournamentViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import Foundation

final class TournamentViewModel {
  var name: String
  var logoURL: URL?

  init(tournament: Tournament) {
    self.name = tournament.name
    self.logoURL = tournament.logoUrl.url
  }
}
