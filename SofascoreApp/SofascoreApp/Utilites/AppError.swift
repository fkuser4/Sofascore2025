//
//  AppError.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 13.04.2025..
//

enum AppError: String, Error {
  case networkError = "Unable to complete your request. Please check your internet connection"
  case invalidSport = "Selected sport is not supported"
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
}
