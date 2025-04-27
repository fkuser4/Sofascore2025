//
//  CustomTextField.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.04.2025..
//
import UIKit

class CustomTextField: UITextField {
  private let leftPadding: CGFloat = 10

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupDefaultStyle()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupDefaultStyle()
  }

  private func setupDefaultStyle() {
    backgroundColor = .loginInputTextFieldBackgroundColor
    layer.cornerRadius = 12
    textColor = .white
    font = .loginRegular
    autocapitalizationType = .none
    autocorrectionType = .no
    tintColor = .white
    layer.borderColor = UIColor.loginErrorBorder.cgColor
  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
  }

  func setPlaceholder(text: String) {
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.loginInputTextPlaceholder,
      .font: UIFont.loginRegular
    ]
    self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
  }
}
