//
//  DatabaseError+Description.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 27.04.2025..
//
import Foundation

extension DatabaseError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .deleteFailed:
      return "Failed to delete the data from the database."
    case .saveFailed:
      return "Failed to save changes to the database."
    case .fetchFailed:
      return "Failed to load data from the database."
    }
  }
}
