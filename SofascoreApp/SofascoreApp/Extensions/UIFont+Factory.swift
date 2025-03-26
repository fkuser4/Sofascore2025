//
//  UIFont+Factory.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIFont {
  static func regular(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
  }

  static func bold(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }

  static func light(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
  }
}
