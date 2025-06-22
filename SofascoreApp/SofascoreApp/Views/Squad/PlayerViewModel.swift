//
//  PlayerViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import Foundation

final class PlayerViewModel {
  var name: String
  var country: String
  var photoURL: URL?

  init(player: Player) {
    self.name = player.name
    self.country = player.country.name
    self.photoURL = player.imageUrl.url
  }
}
