//
//  Player.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
public struct Player: Decodable {
  public let id: Int
  public let name: String
  public let shortName: String
  public let position: String
  public let jerseyNumber: String?
  public let country: Country
  public let imageUrl: String
  public let isForeign: Bool
}
