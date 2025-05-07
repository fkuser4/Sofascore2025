//
//  UIFont+Factory.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIFont {
  // swiftlint:disable force_unwrapping
  static func regular(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Regular", size: size)!
  }

  static func bold(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Bold", size: size)!
  }

  static func light(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Light", size: size)!
  }

  static func medium(size: CGFloat) -> UIFont {
    return UIFont(name: "Roboto-Medium", size: size)!
  }
  // swiftlint:enable force_unwrapping
}
