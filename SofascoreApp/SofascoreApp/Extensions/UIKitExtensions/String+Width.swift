//
//  String+Width.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import UIKit

extension String {
  func width(withFont font: UIFont) -> CGFloat {
    (self as NSString).size(withAttributes: [.font: font]).width
  }
}
