//
//  PeriodViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
final class PeriodViewModel: IncidentViewModel {
  var periodDescription: String

  init(incident: Incident) {
    self.periodDescription = incident.description ?? ""
    if let score = incident.score {
      self.periodDescription += " (\(score))"
    }
    super.init(sortableTime: incident.minute)
  }
}
