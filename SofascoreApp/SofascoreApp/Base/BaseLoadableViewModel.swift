//
//  BaseLoadableViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.06.2025..
//
import Foundation

class BaseLoadableViewModel<T>: LoadableViewModel {
  typealias DataType = T

  private(set) var state: LoadingState<T> = .idle {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.onStateChange?(self.state)
      }
    }
  }

  var onStateChange: ((LoadingState<T>) -> Void)?

  func loadData() {
    fatalError("Override loadData() in subclass")
  }

  func performLoad(_ loadOperation: @escaping (@escaping (Result<T, APIError>) -> Void) -> Void) {
    self.state = .loading

    loadOperation {  result in
      switch result {
      case .success(let data):
        self.state = .loaded(data)
      case .failure(let error):
        self.state = .error(error)
      }
    }
  }
}
