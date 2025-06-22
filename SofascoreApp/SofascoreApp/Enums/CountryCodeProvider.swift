//
//  CountryCodeProvider.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import Foundation

enum CountryCodeProvider {
  private static var allCountries: [(code: String, name: String)] {
    let locale = Locale(identifier: "en_US")


    return Locale.Region.isoRegions.compactMap { region in
      guard let name = locale.localizedString(forRegionCode: region.identifier) else {
        return nil
      }
      return (code: region.identifier, name: name)
    }
  }

  private static let (nameToCodeMap, codeToNameMap) = {
    var nameToCode: [String: String] = [:]
    var codeToName: [String: String] = [:]

    for country in allCountries {
      let lowercasedCode = country.code.lowercased()
      nameToCode[country.name.lowercased()] = lowercasedCode
      codeToName[lowercasedCode] = country.name
    }

    return (nameToCode, codeToName)
  }()

  static func code(for countryName: String) -> String? {
    return nameToCodeMap[countryName.lowercased()]
  }
}
