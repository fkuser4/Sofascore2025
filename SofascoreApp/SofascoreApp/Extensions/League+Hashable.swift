//
//  League+Hashable.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import Foundation

extension League: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
