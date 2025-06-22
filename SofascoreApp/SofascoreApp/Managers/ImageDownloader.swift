//
//  ImageDownloader.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.04.2025..
//
import UIKit

final class ImageDownloader {
  static let shared = ImageDownloader()
  let cache: NSCache<NSString, UIImage> = .init()

  private init() {}

  func downloadImage(url: URL, completed: @escaping (UIImage?) -> Void) {
    downloadImage(from: url.absoluteString, completed: completed)
  }

  func downloadCountryFlag(for countryName: String, completed: @escaping (UIImage?) -> Void) {
    guard let countryCode = CountryCodeProvider.code(for: countryName) else {
      completed(nil)
      return
    }

    let urlString = "https://flagcdn.com/w160/\(countryCode).png"

    downloadImage(from: urlString, completed: completed)
  }

  private func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)

    if let cachedImage = cache.object(forKey: cacheKey) {
      completed(cachedImage)
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
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200,
        let data = data,
        let image = UIImage(data: data)
      else {
        completed(nil)
        return
      }

      self.cache.setObject(image, forKey: cacheKey)
      completed(image)
    }

    task.resume()
  }
}
