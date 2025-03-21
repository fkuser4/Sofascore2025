//
//  EventViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import Foundation
import SofaAcademic
import UIKit

class EventViewModel {

    private let event: Event

    init(event: Event) {
        self.event = event
    }

    var homeTeamName: String {
        event.homeTeam.name
    }

    var awayTeamName: String {
        event.awayTeam.name
    }

    var homeTeamLogoURL: String {
        event.homeTeam.logoUrl ?? ""
    }

    var awayTeamLogoURL: String {
        event.awayTeam.logoUrl ?? ""
    }

    var homeScore: String {
        event.homeScore.map { "\($0)" } ?? "-"
    }

    var awayScore: String {
        event.awayScore.map { "\($0)" } ?? "-"
    }

    var homeScoreTextColor: UIColor {
        scoreTextColor(isHome: true)
    }

    var awayScoreTextColor: UIColor {
        scoreTextColor(isHome: false)
    }

    var homeTeamTextColor: UIColor {
        teamTextColor(isHomeTeam: true)
    }

    var awayTeamTextColor: UIColor {
        teamTextColor(isHomeTeam: false)
    }

    var matchStartTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    var matchStatusText: String {
        switch event.status {
        case .finished:
            return "FT"
        case .inProgress:
            let now = Int(Date().timeIntervalSince1970)
            let elapsed = now - event.startTimestamp
            let minutes = elapsed / 60
            return "\(minutes)'"
        case .halftime:
            return "HT"
        case .notStarted:
            return "-"
        }
    }

    var timeTextColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return .eventLive
        default:
            return .secondary
        }
    }

    private func scoreTextColor(isHome: Bool) -> UIColor {
        switch event.status {
        case .inProgress:
            return .eventLive
        case .finished:
            guard let home = event.homeScore, let away = event.awayScore else {
                return .primary
            }
            if home == away {
                return .primary
            }
            let homeWon = home > away
            return (homeWon == isHome) ? .primary : .secondary
        case .notStarted, .halftime:
            return .clear
        }
    }

    private func teamTextColor(isHomeTeam: Bool) -> UIColor {
        switch event.status {
        case .finished:
            guard let home = event.homeScore, let away = event.awayScore else {
                return .primary
            }
            if home == away {
                return .primary
            }
            let homeWon = home > away
            return (homeWon == isHomeTeam) ? .primary : .secondary
        case .inProgress, .notStarted, .halftime:
            return .primary
        }
    }
}
