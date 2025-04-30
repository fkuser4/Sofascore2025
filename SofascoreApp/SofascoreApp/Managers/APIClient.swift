//
//  APIClient.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import Foundation

enum APIError: Error {
  case networkError
  case invalidSport
  case invalidResponse
  case invalidData
  case unauthorized
  case serverError(status: Int)
}

final class APIClient {
  static let shared = APIClient()
  private let baseURLString = "https://sofa-ios-academy-43194eec0621.herokuapp.com"

  private init() {}

  func login(username: String, password: String) async throws -> LoginResponse {
    let endpoint = baseURLString + "/login"
    guard let url = URL(string: endpoint) else {
      throw APIError.invalidSport
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body = ["username": username, "password": password]
    request.httpBody = try JSONEncoder().encode(body)

    let (data, response): (Data, URLResponse)
    do {
      (data, response) = try await URLSession.shared.data(for: request)
    } catch {
      throw APIError.networkError
    }

    guard let response = response as? HTTPURLResponse else {
      throw APIError.invalidResponse
    }

    switch response.statusCode {
    case 200:
      return try JSONDecoder().decode(LoginResponse.self, from: data)

    case 401:
      throw APIError.unauthorized

    case 500...599:
      throw APIError.serverError(status: response.statusCode)

    default:
      throw APIError.invalidResponse
    }
  }

  func getEvents(sportType: SportType, completed: @escaping (Result<[Event], APIError>) -> Void) {
    let endpoint = baseURLString + "/secure/events?sport=\(sportType.param)"
    guard let accessToken = AuthService.shared.accessToken else {
      completed(.failure(.unauthorized))
      return
    }

    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidSport))
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

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.invalidResponse))
        return
      }

      guard let data = data else {
        return completed(.failure(.invalidData))
      }

      do {
        let events = try JSONDecoder().decode([Event].self, from: data)
        completed(.success(events))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    task.resume()
  }
}
