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
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
}
