//
//  EventsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import SofaAcademic

class EventsViewModel {
  var currentEvents: [League: [Event]] = [:]
  var displayedLeagues: [League] = []

  init(currentEvents: [League: [Event]], displayedLeagues: [League]) {
    self.currentEvents = currentEvents
    self.displayedLeagues = displayedLeagues
  }
}
