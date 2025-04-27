//
//  SettingsOverviewViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 27.04.2025..
//

import Foundation
import SofaAcademic

final class SettingsOverviewViewModel {
  private(set) var nameText: String = "…" {
    didSet { nameDidChange?(nameText) }
  }
  private(set) var eventsText: String = "…" {
    didSet { eventsDidChange?(eventsText) }
  }
  private(set) var leaguesText: String = "…" {
    didSet { leaguesDidChange?(leaguesText) }
  }

  var nameDidChange: ((String) -> Void)?
  var eventsDidChange: ((String) -> Void)?
  var leaguesDidChange: ((String) -> Void)?

  func loadAll() {
    loadName()
    loadEventsCount()
    loadLeaguesCount()
  }

  private func loadName() {
    nameText = UserDefaults.standard.string(forKey: "name") ?? "Name has not been set"
  }

  private func loadEventsCount() {
    DataPersistenceManager.shared.fetchAllEvents { [weak self] result in
      guard let self = self else { return }
      let text: String
      switch result {
      case .success(let entities):
        text = "Events: \(entities.count)"
        print(entities)
      case .failure(let error):
        text = "Events: \(error.localizedDescription)"
      }
      self.eventsText = text
    }
  }

  private func loadLeaguesCount() {
    DataPersistenceManager.shared.fetchAllLeagues { [weak self] result in
      guard let self = self else { return }
      let text: String
      switch result {
      case .success(let entities):
        text = "Leagues: \(entities.count)"
      case .failure(let error):
        text = "Leagues: \(error.localizedDescription)"
      }
      self.leaguesText = text
    }
  }
}
