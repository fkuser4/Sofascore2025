//
//  ImageDownloader.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.04.2025..
//
import UIKit

class ImageDownloader {
  static let shared = ImageDownloader()
  let cache: NSCache<NSString, UIImage> = .init()

  private init() {}

  func downloadImage(url: URL, completed: @escaping (UIImage?) -> Void) {
    let urlString = url.absoluteString

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
