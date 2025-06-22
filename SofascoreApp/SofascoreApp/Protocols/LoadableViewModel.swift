//
//  LoadableViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.06.2025..
//
import Foundation

protocol LoadableViewModel: AnyObject {
  associatedtype DataType

  var state: LoadingState<DataType> { get }
  var onStateChange: ((LoadingState<DataType>) -> Void)? { get set}

  func loadData()
}
