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
    case .invalidURL:
      return "Invalid request URL."
    case .invalidResponse:
      return "Invalid response from the server. Please try again."
    case .invalidData:
      return "The data received from the server was invalid. Please try again."
    case .invalidLogin:
      return "Username or password is incorrect."
    case .serverError(let status):
      return "Server error occurred (code \(status)). Please try again later."
    case .unauthorized:
      return "You have to log in to use this feature."
    case .notFound:
      return "The requested resource was not found."
    }
  }
}
