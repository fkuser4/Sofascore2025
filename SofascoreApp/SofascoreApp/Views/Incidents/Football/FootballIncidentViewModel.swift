//
//  IncidentViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//

final class FootballIncidentViewModel: IncidentViewModel {
  var player: String
  var description: String
  var minute: String
  var type: IncidentType
  var score: String
  var incidentIcon: String
  var isHomeTeam: Bool

  init(incident: Incident) {
    self.player = incident.player ?? "N/A"
    self.description = incident.description ?? "Foul"
    self.minute = "\(incident.minute)'"
    self.type = incident.type
    self.score = incident.score ?? "N/A"
    self.isHomeTeam = incident.isHomeTeam ?? true

    switch incident.type {
    case .foul:
      incidentIcon = "ic_foul"
    case .goal:
      incidentIcon = "ic_goal"
    case .redCard:
      incidentIcon = "ic_red_card"
    case .yellowCard:
      incidentIcon = "ic_yellow_card"
    default:
      incidentIcon = "ic_goal"
    }

    super.init(sortableTime: incident.minute)
  }
}
