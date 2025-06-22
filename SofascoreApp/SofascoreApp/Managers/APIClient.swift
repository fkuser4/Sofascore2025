//
//  APIClient.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import Foundation

enum APIError: Error {
  case networkError
  case invalidURL
  case invalidResponse
  case invalidData
  case invalidLogin
  case serverError(status: Int)
  case unauthorized
  case notFound
}

final class APIClient {
  static let shared = APIClient()
  private let baseURLString = "https://sofa-ios-academy-43194eec0621.herokuapp.com"

  private init() {}

  func login(username: String, password: String) async throws -> LoginResponse {
    let endpoint = baseURLString + "/login"
    guard let url = URL(string: endpoint) else {
      throw APIError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body = ["username": username, "password": password]
    request.httpBody = try JSONEncoder().encode(body)

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponse
      }

      switch httpResponse.statusCode {
      case 200:
        return try JSONDecoder().decode(LoginResponse.self, from: data)
      case 401:
        throw APIError.invalidLogin
      case 500...599:
        throw APIError.serverError(status: httpResponse.statusCode)
      default:
        throw APIError.invalidResponse
      }
    } catch {
      if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
        throw APIError.networkError
      }
      throw error
    }
  }

  func getEvents(sportType: SportType, completed: @escaping (Result<[Event], APIError>) -> Void) {
    let endpoint = "/events?sport=\(sportType.param)"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getEvents(forLeague leagueId: Int, completed: @escaping (Result<[Event], APIError>) -> Void) {
    let endpoint = "/leagues/\(leagueId)/matches"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getEvent(by id: Int, completed: @escaping (Result<Event, APIError>) -> Void) {
    let endpoint = "/events/\(id)"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getIncidents(for eventId: Int, completed: @escaping (Result<[Incident], APIError>) -> Void) {
    let endpoint = "/events/\(eventId)/incidents"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getStandings(forLeague leagueId: Int, completed: @escaping (Result<[StandingsEntry], APIError>) -> Void) {
    let endpoint = "/leagues/\(leagueId)/standings"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getTeam(by id: Int, completed: @escaping (Result<TeamDetails, APIError>) -> Void) {
    let endpoint = "/teams/\(id)"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getTournaments(forTeam teamId: Int, completed: @escaping (Result<[Tournament], APIError>) -> Void) {
    let endpoint = "/teams/\(teamId)/tournaments"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }

  func getPlayers(forTeam teamId: Int, completed: @escaping (Result<[Player], APIError>) -> Void) {
    let endpoint = "/teams/\(teamId)/players"
    performAuthenticatedRequest(endpoint: endpoint, completed: completed)
  }
}

private extension APIClient {
  // Kept unified to preserve clarity and encapsulation; splitting would unnecessarily expose internal logic to higher-level API methods.
  // swiftlint:disable:next cyclomatic_complexity
  func performAuthenticatedRequest<T: Decodable>(endpoint: String, completed: @escaping (Result<T, APIError>) -> Void) {
    guard let accessToken = AuthService.shared.accessToken else {
      completed(.failure(.unauthorized))
      return
    }

    guard let url = URL(string: baseURLString + endpoint) else {
      completed(.failure(.invalidURL))
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if error != nil {
        completed(.failure(.networkError))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse else {
        completed(.failure(.invalidResponse))
        return
      }

      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }

      switch httpResponse.statusCode {
      case 200:
        do {
          let result = try JSONDecoder().decode(T.self, from: data)
          completed(.success(result))
        } catch {
          completed(.failure(.invalidData))
        }
      case 401:
        completed(.failure(.unauthorized))
      case 404:
        completed(.failure(.notFound))
      case 500...599:
        completed(.failure(.serverError(status: httpResponse.statusCode)))
      default:
        completed(.failure(.invalidResponse))
      }
    }
    task.resume()
  }
}
