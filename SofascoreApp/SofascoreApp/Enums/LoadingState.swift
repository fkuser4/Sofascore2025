//
//  LoadingState.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.06.2025..
//
import Foundation

enum LoadingState<T> {
  case idle
  case loading
  case loaded(T)
  case error(Error)
}
