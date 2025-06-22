//
//  TimeEventFormatter.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import Foundation

struct TimeEventFormatter: EventFormatterProtocol {
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
  }()

  func formatMatchStatus(from event: Event) -> String {
    switch event.status {
    case .finished: return "FT"
    case .inProgress:
      let now = Int(Date().timeIntervalSince1970)
      let elapsed = now - event.startTimestamp
      let minutes = elapsed / 60
      return "\(minutes)'"
    case .halftime: return "HT"
    case .notStarted: return "-"
    }
  }

  func formatStartTimeHHmm(from timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    return dateFormatter.string(from: date)
  }

  func formatShortDate(from timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    return dateFormatter.string(from: date)
  }
}
