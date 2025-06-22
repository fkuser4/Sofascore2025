//
//  BasketballIncidentViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
final class BasketballIncidentViewModel: IncidentViewModel {
  var minute: String
  var score: String
  var incidentIcon: String
  var isHomeTeam: Bool
  var showBottomBorder: Bool = true

  init(incident: Incident) {
    self.minute = "\(incident.minute)'"
    self.score = incident.score ?? "N/A"
    self.isHomeTeam = incident.isHomeTeam ?? true

    switch incident.scoreDiff {
    case 1:
      incidentIcon = "ic_basketball_incident"
    case 2:
      incidentIcon = "ic_two_points"
    case 3:
      incidentIcon = "ic_three_points"
    default:
      incidentIcon = "ic_basketball_incident"
    }

    super.init(sortableTime: incident.minute)
  }
}
