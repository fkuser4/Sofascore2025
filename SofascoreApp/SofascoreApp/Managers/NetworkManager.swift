//
//  NetworkManager.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//
import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  private let baseURL = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport="
  let cache: NSCache<NSString, UIImage> = .init()

  private init() {}

  func getEvents(sportType: SportType, completed: @escaping (Result<[Event], AppError>) -> Void) {
    let endpoint = baseURL + sportType.param

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

  func downloadImage(urlString: String, completed: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)

    if let image = cache.object(forKey: cacheKey) {
      completed(image)
      return
    }

    guard let url = URL(string: urlString) else {
      completed(nil)
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard
        let self = self,
        error == nil,
        let response = response as? HTTPURLResponse, response.statusCode == 200,
        let data = data,
        let image = UIImage(data: data) else {
        completed(nil)
        return
      }

      self.cache.setObject(image, forKey: cacheKey)
      completed(image)
    }
    task.resume()
  }
}
