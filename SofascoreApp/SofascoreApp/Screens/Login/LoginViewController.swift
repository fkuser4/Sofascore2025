//
//  LoginViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.04.2025..
//
import UIKit
import SnapKit
import SofaAcademic

class LoginViewController: UIViewController, BaseViewProtocol {
  private var loginView: LoginView = .init()

  override func viewDidLoad() {
    super.viewDidLoad()

    addViews()
    setupConstraints()
    styleViews()
    setupBindings()
  }

  func addViews() {
    view.addSubview(loginView)
  }

  func setupConstraints() {
    loginView.snp.makeConstraints { make in
      make.trailing.leading.equalToSuperview()
      make.centerY.equalToSuperview()
      make.centerX.equalToSuperview()
    }
  }

  func styleViews() {
    view.backgroundColor = .primaryBackgroundColor
  }

  func setupBindings() {
    loginView.didTapLogin = { [weak self] username, password in
      Task {
        do {
          try await AuthService.shared.login(
            username: username?.trimmingCharacters(in: .whitespaces) ?? "",
            password: password?.trimmingCharacters(in: .whitespaces) ?? ""
          )
          AppRouter.shared.showMain(animated: true)
        } catch let apiError as APIError {
          self?.loginView.errorMessage = apiError.localizedDescription
        } catch {
          self?.loginView.errorMessage = "Unexpected error. Please try again."
        }
      }
    }
  }
}
