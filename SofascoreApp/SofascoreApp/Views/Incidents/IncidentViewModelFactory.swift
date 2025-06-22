//
//  IncidentViewModelFactory.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
enum IncidentViewModelFactory {
  static func makeViewModel(for incident: Incident, sport: SportType) -> IncidentViewModel {
    switch sport {
    case .football:
      return mapFootballIncident(incident)
    case .basketball:
      return mapBasketballIncident(incident)
    case .americanFootball:
      return mapAmericanFootballIncident(incident)
    }
  }

  private static func mapFootballIncident(_ incident: Incident) -> IncidentViewModel {
    switch incident.type {
    case .periodEnd:
      return PeriodViewModel(incident: incident)
    default:
      return FootballIncidentViewModel(incident: incident)
    }
  }

  private static func mapBasketballIncident(_ incident: Incident) -> IncidentViewModel {
    switch incident.type {
    case .periodEnd:
      return PeriodViewModel(incident: incident)
    default:
      return BasketballIncidentViewModel(incident: incident)
    }
  }

  private static func mapAmericanFootballIncident(_ incident: Incident) -> IncidentViewModel {
    switch incident.type {
    case .periodEnd:
      return PeriodViewModel(incident: incident)
    default:
      return AmericanFootballIncidentViewModel(incident: incident)
    }
  }
}
