//
//  SportType.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
enum SportType: Int, CaseIterable {
  case football
  case basketball
  case americanFootball

  var title: String {
    switch self {
    case .football: return "Football"
    case .basketball: return "Basketball"
    case .americanFootball: return "Am. Football"
    }
  }

  var iconName: String {
    switch self {
    case .football: return "ic_football"
    case .basketball: return "ic_basketball"
    case .americanFootball: return "ic_american_football"
    }
  }
}
