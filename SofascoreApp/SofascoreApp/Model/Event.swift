//
//  Event.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 12.04.2025..
import Foundation

public struct Event: Decodable {
  public let id: Int
  public let homeTeam: Team
  public let awayTeam: Team
  public let startTimestamp: Int
  public let status: EventStatus
  public let league: League
  public let homeScore: Int?
  public let awayScore: Int?
}
