//
//  APIClient.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import Foundation

class APIClient {
  static let shared = APIClient()
  private let baseURLString = "https://sofa-ios-academy-43194eec0621.herokuapp.com"

  private init() {}

  func getEvents(sportType: SportType, completed: @escaping (Result<[Event], APIError>) -> Void) {
    let endpoint = baseURLString + "/events?sport=\(sportType.param)"

    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidSport))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
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

enum APIError: Error {
  case networkError
  case invalidSport
  case invalidResponse
  case invalidData
}
