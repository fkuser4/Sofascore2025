//
//  UIImageView+URL.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIImageView {
  func loadImage(from url: URL?) {
    guard let url = url else { return }

    ImageDownloader.shared.downloadImage(url: url) { image in
      guard let image = image else { return }

      DispatchQueue.main.async {
        self.alpha = 0
        self.image = image
        UIView.animate(withDuration: 0.15) {
          self.alpha = 1
        }
      }
    }
  }

  func loadCountryFlag(for countryName: String) {
    ImageDownloader.shared.downloadCountryFlag(for: countryName) { image in
      guard let image = image else { return }

      DispatchQueue.main.async {
        self.alpha = 0
        self.image = image
        UIView.animate(withDuration: 0.15) {
          self.alpha = 1
        }
      }
    }
  }
}
