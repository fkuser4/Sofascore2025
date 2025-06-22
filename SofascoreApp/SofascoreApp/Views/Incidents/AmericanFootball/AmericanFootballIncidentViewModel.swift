//
//  AmericanFootballViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 18.06.2025..
//
final class AmericanFootballIncidentViewModel: IncidentViewModel {
  var player: String
  var minute: String
  var score: String
  var incidentIcon: String
  var isHomeTeam: Bool

  init(incident: Incident) {
    self.player = incident.player ?? "N/A"
    self.minute = "\(incident.minute)'"
    self.score = incident.score ?? "N/A"
    self.isHomeTeam = incident.isHomeTeam ?? true
    switch incident.scoreDiff {
    case 6:
      self.incidentIcon = "ic_score_touchdown"
    case 3:
      self.incidentIcon = "ic_score_field_goal"
    case 1:
      self.incidentIcon = "ic_score_extra_point"
    case 2:
      self.incidentIcon = "ic_score_two_point_conversion"
    default:
      self.incidentIcon = "ic_score_touchdown"
    }

    super.init(sortableTime: incident.minute)
  }
}
