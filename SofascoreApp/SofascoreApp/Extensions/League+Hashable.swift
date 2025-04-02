//
//  League+Hashable.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import Foundation
import SofaAcademic

extension League: @retroactive Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
