//
//  APIError+Description.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.04.2025..
//
import Foundation

extension APIError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .networkError:
      return "Unable to complete your request. Please check your internet connection"
    case .invalidSport:
      return "Selected sport is not supported"
    case .invalidResponse:
      return "Invalid response from the server. Please try again."
    case .invalidData:
      return "The data received from the server was invalid. Please try again."
    }
  }
}
