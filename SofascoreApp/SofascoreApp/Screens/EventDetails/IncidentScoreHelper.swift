//
//  IncidentScoreHelper.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
enum IncidentScoreHelper {
  static func calculateScores(for sortedIncidents: [Incident]) -> [Incident] {
    var homeScore = 0
    var awayScore = 0
    var enriched: [Incident] = []

    for incident in sortedIncidents {
      var updatedScore: String?

      if incident.type == .goal, let diff = incident.scoreDiff {
        if incident.isHomeTeam == true {
          homeScore += diff
        } else if incident.isHomeTeam == false {
          awayScore += diff
        }
      }

      if incident.type != .periodEnd {
        updatedScore = "\(homeScore) - \(awayScore)"
      }

      let updated = Incident(
        type: incident.type,
        minute: incident.minute,
        isHomeTeam: incident.isHomeTeam,
        extraMinute: incident.extraMinute,
        player: incident.player,
        scoreDiff: incident.scoreDiff,
        score: updatedScore,
        description: incident.description
      )

      enriched.append(updated)
    }

    return enriched
  }
}
