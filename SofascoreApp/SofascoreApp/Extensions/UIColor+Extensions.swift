//
//  UIColor+Extensions.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static let eventLive = UIColor(hex: "#E93030")
    static let primary = UIColor(hex: "#121212")
    static let secondary = UIColor.primary.withAlphaComponent(0.4)
}
