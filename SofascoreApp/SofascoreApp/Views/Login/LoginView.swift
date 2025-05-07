//
//  LoginView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.04.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class LoginView: BaseView {
  private var logoImageView: UIImageView = .init()
  private var subtitleLabel: UILabel = .init()
  private var usernameTextField: CustomTextField = .init()
  private var passwordTextField: CustomTextField = .init()
  private var loginButton: UIButton = .init()
  private var invalidLoginView: InvalidLoginView = .init()

  var didTapLogin: ((String?, String?) -> Void)?
  var errorMessage: String? {
    didSet {
      invalidLoginView.isHidden = false
      invalidLoginView.errorMessage = errorMessage
      loginButton.isEnabled = true
      loginButton.alpha = 1.0
      loginButton.setTitle("Login", for: .normal)
      [usernameTextField, passwordTextField].forEach {
        $0.layer.borderWidth = 1
        $0.isUserInteractionEnabled = true
      }
    }
  }

  private var containerStackView: UIStackView = .init()

  override func addViews() {
    addSubview(containerStackView)
    [logoImageView, subtitleLabel, invalidLoginView, usernameTextField, passwordTextField, loginButton].forEach {
      containerStackView.addArrangedSubview($0)
    }
  }

  override func styleViews() {
    containerStackView.axis = .vertical
    containerStackView.alignment = .center
    containerStackView.spacing = 20
    containerStackView.setCustomSpacing(35, after: subtitleLabel)

    logoImageView.image = .icHeaderTitle
    logoImageView.contentMode = .scaleAspectFill

    subtitleLabel.text = "Sign in to continue"
    subtitleLabel.textColor = .loginSubtitle
    subtitleLabel.font = .loginRegular

    usernameTextField.setPlaceholder(text: "Username")

    passwordTextField.setPlaceholder(text: "Password")
    passwordTextField.isSecureTextEntry = true

    loginButton.setTitle("Login", for: .normal)
    loginButton.setTitleColor(.primaryBackgroundColor, for: .normal)
    loginButton.backgroundColor = .white
    loginButton.titleLabel?.font = .loginMedium
    loginButton.layer.cornerRadius = 12
    loginButton.isEnabled = false
    loginButton.alpha = 0.6

    invalidLoginView.isHidden = true
  }

  override func setupBinding() {
    usernameTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
  }

  override func setupConstraints() {
    containerStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    logoImageView.snp.makeConstraints { make in
      make.height.equalTo(25)
    }

    [usernameTextField, passwordTextField, loginButton].forEach {
      $0.snp.makeConstraints { make in
        make.height.equalTo(48)
        make.leading.trailing.equalToSuperview().inset(30)
      }
    }

    invalidLoginView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(30)
    }
  }

  @objc private func textFieldsDidChange() {
    let isUsernameEmpty = usernameTextField.text?.isEmpty ?? true
    let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true

    let shouldEnable = !isUsernameEmpty && !isPasswordEmpty

    loginButton.isEnabled = shouldEnable
    loginButton.alpha = shouldEnable ? 1.0 : 0.6
  }

  @objc private func loginTapped() {
    loginButton.isEnabled = false
    loginButton.alpha = 0.6
    loginButton.setTitle("Signing in...", for: .normal)
    invalidLoginView.isHidden = true
    [usernameTextField, passwordTextField].forEach {
      $0.layer.borderWidth = 0
      $0.isUserInteractionEnabled = false
    }

    didTapLogin?(usernameTextField.text, passwordTextField.text)
  }
}
