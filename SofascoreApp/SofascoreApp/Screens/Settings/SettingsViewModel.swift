//
//  SettingsViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 27.04.2025..
//
import Foundation
import SofaAcademic

final class SettingsViewModel {
  var nameDidChange: ((String) -> Void)?
  var eventsCountDidChange: ((String) -> Void)?
  var leaguesCountDidChange: ((String) -> Void)?
  private let dataPersistenceManager: DataPersistenceManager = .shared
  private let userDefaults: UserDefaults = .standard

  private(set) var logoutDidTrigger = {
    DataPersistenceManager.shared.deleteAllObjects { result in
      switch result {
      case .success:
        break
      case .failure(let error):
        print("Error deleting events: \(error)")
      }
    }
    UserDefaults.standard.set(nil, forKey: "name")
    AuthService.shared.logout()
    AppRouter.shared.showLogin(animated: true)
  }

  func loadAll() {
    loadName()
    loadEventsCount()
    loadLeaguesCount()
  }

  private func loadName() {
    let name = userDefaults.string(forKey: "name") ?? "Name has not been set"
    nameDidChange?(name)
  }

  private func loadEventsCount() {
    dataPersistenceManager.fetchAllEvents { [weak self] result in
      guard let self = self else { return }
      let eventsCount: String
      switch result {
      case .success(let entities):
        eventsCount = "Events: \(entities.count)"
        print(entities)
      case .failure(let error):
        eventsCount = "Events: \(error.localizedDescription)"
      }
      eventsCountDidChange?(eventsCount)
    }
  }

  private func loadLeaguesCount() {
    dataPersistenceManager.fetchAllLeagues { [weak self] result in
      guard let self = self else { return }
      let leagueCount: String
      switch result {
      case .success(let entities):
        leagueCount = "Leagues: \(entities.count)"
      case .failure(let error):
        leagueCount = "Leagues: \(error.localizedDescription)"
      }
      leaguesCountDidChange?(leagueCount)
    }
  }
}
