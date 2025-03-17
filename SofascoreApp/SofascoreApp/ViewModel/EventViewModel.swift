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
    private var homeworkDataSource = Homework2DataSource()

    func getEventsByName(leagueName: LeagueNames) -> [EventData]? {
        let events: [SofaAcademic.Event]

        switch leagueName {
        case .laliga:
            events = homeworkDataSource.laLigaEvents()
        default:
            events = homeworkDataSource.laLigaEvents()
        }

        return parseEventData(from: events)
    }

    private func parseEventData(from events: [SofaAcademic.Event]) -> [EventData]? {
        return events.map { event in
            return EventData(
                id: event.id,
                homeTeam: TeamData(id: event.homeTeam.id, name: event.homeTeam.name, logoUrl: event.homeTeam.logoUrl),
                awayTeam: TeamData(id: event.awayTeam.id, name: event.awayTeam.name, logoUrl: event.awayTeam.logoUrl),
                status: getStatusText(event.status),
                startTimestamp: event.startTimestamp,
                homeScore: event.homeScore,
                awayScore: event.awayScore
            )
        }
    }
    
    public func fetchTeamLogo(from urlString: String?) -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString),
              let imageData = try? Data(contentsOf: url) else {
            return UIImage(named: "placeholder")
        }
        return UIImage(data: imageData)
    }
    
    
    
    public func getTeamTextColor(eventData: EventData, isHomeTeam: Bool) -> UIColor {
            switch eventData.status {
            case "Finished":
                guard let homeScore = eventData.homeScore, let awayScore = eventData.awayScore else {
                    return Colors.textPrimary
                }
                let isHomeWinner = homeScore > awayScore
                return (isHomeWinner == isHomeTeam) ? Colors.textPrimary : Colors.textSecondary

            case "Live":
                return Colors.textPrimary

            case "Upcoming":
                return Colors.textPrimary

            default:
                return Colors.textPrimary
            }
        }

    public func getScoreTextColor(eventData: EventData, isHomeScore: Bool) -> UIColor {
        switch eventData.status {
        case "Live":
            return Colors.live
            
        case "Finished":
            guard let homeScore = eventData.homeScore, let awayScore = eventData.awayScore else {
                return Colors.textPrimary
            }
            
            if homeScore == awayScore {
                return Colors.textPrimary
            }
            
            let isHomeWinner = homeScore > awayScore
            return (isHomeWinner == isHomeScore) ? Colors.textPrimary : Colors.textSecondary
            
        case "Upcoming":
            return .clear
            
        default:
            return Colors.textPrimary
        }
    }
    
    public func getMatchTimeString(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    public func getMatchStatusText(eventData: EventData) -> String {
        switch eventData.status {
        case "Finished":
            return "FT"
        case "Live":
            let currentTime = Int(Date().timeIntervalSince1970)
            let elapsedSeconds = currentTime - eventData.startTimestamp
            let minutes = elapsedSeconds / 60
            return "\(minutes)'"
        case "Upcoming":
            return "-"
        default:
            return eventData.status
        }
    }

    public func getTimeTextColor(eventData: EventData) -> UIColor {
        switch eventData.status {
        case "Live":
            return Colors.live
        default:
            return Colors.textSecondary
        }
    }

    private func getStatusText(_ status: SofaAcademic.EventStatus) -> String {
        switch status {
        case .notStarted:
            return "Upcoming"
        case .inProgress:
            return "Live"
        case .halftime:
            return "Halftime"
        case .finished:
            return "Finished"
        }
    }
}

