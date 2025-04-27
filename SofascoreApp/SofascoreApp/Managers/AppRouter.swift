//
//  AppRouter.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 25.04.2025..
//
import UIKit

final class AppRouter {
  static let shared = AppRouter()
  private init() {}

  weak var window: UIWindow?

  func start(window: UIWindow) {
    self.window = window
    showInitial(animated: false)
    window.makeKeyAndVisible()
  }

  func showInitial(animated: Bool) {
    if AuthService.shared.isLoggedIn {
      showMain(animated: animated)
    } else {
      showLogin(animated: animated)
    }
  }

  func showMain(animated: Bool) {
    let mainViewConteroller = MainViewController()
    swapRoot(to: UINavigationController(rootViewController: mainViewConteroller), animated: true)
  }

  func showLogin(animated: Bool) {
    let loginViewController = LoginViewController()
    swapRoot(to: UINavigationController(rootViewController: loginViewController), animated: true)
  }

  private func swapRoot(to vc: UIViewController, animated: Bool) { // swiftlint:disable:this identifier_name
    guard let window = self.window else { return }
    let change = { window.rootViewController = vc }
    if animated {
      UIView.transition(
        with: window,
        duration: 0.3,
        options: .transitionCrossDissolve,
        animations: change,
        completion: nil)
    } else {
      change()
    }
  }
}
