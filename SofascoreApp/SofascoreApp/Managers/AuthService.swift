//
//  AuthService.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 25.04.2025..
//
import KeychainAccess
import Foundation

final class AuthService {
  static let shared = AuthService()
  private let keychain = Keychain(service: "com.sofascore.app-accessToken")
  private let userDefaults = UserDefaults.standard

  var isLoggedIn: Bool {
    return accessToken != nil
  }

  var accessToken: String? {
    return keychain["accessToken"]
  }

  func login(username: String, password: String) async throws {
    let loginResponse = try await APIClient.shared.login(username: username, password: password)
    keychain["accessToken"] = loginResponse.token
    userDefaults.set(loginResponse.name, forKey: "name")
  }

  func logout() {
    keychain["accessToken"] = nil
  }
}
