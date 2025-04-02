//
//  League+Equatable.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import Foundation
import SofaAcademic

extension League: @retroactive Equatable {
  public static func == (lhs: League, rhs: League) -> Bool {
    return lhs.id == rhs.id
  }
}
