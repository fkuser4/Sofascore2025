//
//  String+URL.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.03.2025..
//
import Foundation

public extension String {
  var url: URL? {
    URL(string: self)
  }
}
