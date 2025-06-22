//
//  HeaderViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import Foundation

struct HeaderViewModel {
  var title: String
  var country: String?
  var imageURL: URL?

  init(title: String, imageURL: URL?, country: String? = nil) {
    self.title = title
    self.country = country
    self.imageURL = imageURL
  }
}
