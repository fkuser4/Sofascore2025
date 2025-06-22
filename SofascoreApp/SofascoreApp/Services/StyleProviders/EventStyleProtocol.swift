//
//  EventStyleProtocol.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import UIKit

protocol EventStyleProviderProtocol {
  func scoreTextColor(for event: Event, isHome: Bool) -> UIColor
  func teamTextColor(for event: Event, isHomeTeam: Bool) -> UIColor
  func matchStatusTextColor(for status: EventStatus) -> UIColor
}
