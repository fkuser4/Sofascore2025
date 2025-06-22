//
//  EventFormatterProtocol.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import Foundation

protocol EventFormatterProtocol {
  func formatMatchStatus(from event: Event) -> String
  func formatStartTimeHHmm(from timestamp: Int) -> String
}
