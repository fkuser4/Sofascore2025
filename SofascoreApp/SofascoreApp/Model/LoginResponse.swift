//
//  LoginResponse.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 25.04.2025..
//
import Foundation

struct LoginResponse: Decodable {
  let name: String
  let token: String
}
