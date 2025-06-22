//
//  IncidentType.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
public enum IncidentType: String, Decodable {
  case goal = "GOAL"
  case periodEnd = "PERIOD_END"
  case foul = "FOUL"
  case yellowCard = "YELLOW_CARD"
  case redCard = "RED_CARD"

  public var displayValue: String {
    switch self {
    case .goal: return "Goal"
    case .periodEnd: return "Period End"
    case .foul: return "Foul"
    case .yellowCard: return "Yellow Card"
    case .redCard: return "Red Card"
    }
  }
}
