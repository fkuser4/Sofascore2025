//
//  ManagerViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import Foundation

class ManagerViewModel {
  var name: String
  var countryName: String
  var photoURL: URL?

  init(manager: Manager) {
    self.name = "Manager: " + manager.name
    self.countryName = manager.country.name
    self.photoURL = manager.imageUrl.url
  }
}
