//
//  StandingsEntry.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
public struct StandingsEntry: Decodable {
  let team: Team
  let position: Int
  let matches: Int
  let wins: Int
  let losses: Int
  let draws: Int
  let percentage: Double?
  let points: Int?
  let scoreFor: Int
  let scoreAgainst: Int
  let scoreFormatted: String
}
