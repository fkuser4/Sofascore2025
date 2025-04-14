//
//  UIImageView+URL.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIImageView {
  func loadImage(from url: String?) {
    guard let urlString = url else { return }

    NetworkManager.shared.downloadImage(urlString: urlString) { image in
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
}
