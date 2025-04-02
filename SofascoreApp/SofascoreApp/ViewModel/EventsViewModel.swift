//
//  EventsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 02.04.2025..
//
import SofaAcademic

class EventsViewModel {
  var allEvents: [Event] = []
  var currentEvents: [League: [Event]] = [:]
  var displayedLeagues: [League] = []

  init(allEvents: [Event], currentEvents: [League: [Event]], displayedLeagues: [League]) {
    self.allEvents = allEvents
    self.currentEvents = currentEvents
    self.displayedLeagues = displayedLeagues
  }
}
