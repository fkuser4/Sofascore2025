//
//  UIImageView+URL.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIImageView {
  func loadImage(from url: URL?) {
    guard let url = url else {
      self.image = nil
      return
    }

    Task {
      if let data = await Self.downloadImageData(from: url), let image = UIImage(data: data) {
        self.image = image
      }
    }
  }

  private static func downloadImageData(from url: URL) async -> Data? {
    do {
      let (localURL, _) = try await URLSession.shared.download(from: url)
      return try Data(contentsOf: localURL)
    } catch {
      print("Error downloading image: \(error)")
      return nil
    }
  }
}
