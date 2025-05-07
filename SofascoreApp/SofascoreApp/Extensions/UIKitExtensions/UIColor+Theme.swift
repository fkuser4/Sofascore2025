//
//  UIColor+Theme.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

extension UIColor {
  static let eventLive = UIColor(hex: "#E93030")
  static let primary = UIColor(hex: "#121212")
  static let secondary = primary.withAlphaComponent(0.4)
  static let primaryBackgroundColor = UIColor(hex: "#374DF5")
  static let textOnPrimaryBackgroundColor = UIColor(hex: "#FFFFFF")
  static let secondaryBackgroundColor = UIColor(hex: "#FFFFFF")
  static let backIconOnWhite = UIColor(hex: "#121212")
  static let backIconOnBlue = UIColor(hex: "#FFFFFF")
  static let eventDetailsBackgroundColor = UIColor(hex: "#EFF3F8")
  static let loginInputTextFieldBackgroundColor: UIColor = white.withAlphaComponent(0.2)
  static let loginSubtitle = white.withAlphaComponent(0.8)
  static let loginInputTextPlaceholder: UIColor = white.withAlphaComponent(0.6)
  static let loginErrorBackground = UIColor(hex: "#EF4444").withAlphaComponent(0.2)
  static let loginErrorBorder = UIColor(hex: "#EF4444").withAlphaComponent(0.5)
}
