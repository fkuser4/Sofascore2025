//
//  League.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 12.04.2025..
//
import Foundation

public struct League: Decodable {
  public let id: Int
  public let name: String
  public let country: Country
  public let logoUrl: String
}
