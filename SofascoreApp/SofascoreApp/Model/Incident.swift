//
//  Incident.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
public struct Incident: Decodable, Equatable {
  let type: IncidentType
  let minute: Int
  public let isHomeTeam: Bool?
  public let extraMinute: Int?
  public let player: String?
  public let scoreDiff: Int?
  public let score: String?
  public let description: String?
}
