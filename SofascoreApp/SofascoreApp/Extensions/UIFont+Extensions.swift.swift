//
//  UIFont+Extensions.swift.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.03.2025..
//
import UIKit

struct Fonts {
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

extension UIFont {
    static let primaryTitle = Fonts.bold(size: 14)
    static let bodyRegular = Fonts.regular(size: 14)
    static let bodyLight = Fonts.regular(size: 12)
}
