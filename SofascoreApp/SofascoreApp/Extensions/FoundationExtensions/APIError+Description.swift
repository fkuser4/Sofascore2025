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
      return "Unable to complete your request. Please check your internet connection."
    case .invalidSport:
      return "Selected sport is not supported."
    case .invalidResponse:
      return "Invalid response from the server. Please try again."
    case .invalidData:
      return "The data received from the server was invalid. Please try again."
    case .unauthorized:
      return "Username or password is incorrect."
    case .serverError(let status):
      return "Server error occurred (code \(status)). Please try again later."
    }
  }
}
