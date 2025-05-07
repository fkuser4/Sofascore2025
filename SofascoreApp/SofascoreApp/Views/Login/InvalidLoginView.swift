//
//  InvalidLoginView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 25.04.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class InvalidLoginView: BaseView {
  private var errorMessageLabel: UILabel = .init()
  private var errorImageView: UIImageView = .init()

  var errorMessage: String? {
    didSet {
      errorMessageLabel.text = errorMessage
    }
  }

  override func addViews() {
    addSubview(errorImageView)
    addSubview(errorMessageLabel)
  }

  override func setupConstraints() {
    errorImageView.snp.makeConstraints { make in
      make.size.equalTo(20)
      make.leading.equalToSuperview().inset(12)
      make.top.equalToSuperview().inset(10)
      make.bottom.lessThanOrEqualToSuperview().inset(10)
    }

    errorMessageLabel.snp.makeConstraints { make in
      make.leading.equalTo(errorImageView.snp.trailing).offset(10)
      make.trailing.equalToSuperview().inset(5)
      make.top.equalToSuperview().inset(11)
      make.bottom.lessThanOrEqualToSuperview().inset(10)
    }
  }

  override func styleViews() {
    backgroundColor = .loginErrorBackground
    layer.cornerRadius = 8
    layer.borderWidth = 1
    layer.borderColor = UIColor.loginErrorBorder.cgColor

    errorImageView.image = UIImage(systemName: "info.circle")
    errorImageView.tintColor = .white
    errorMessageLabel.textColor = .white
    errorMessageLabel.font = .loginRegular
    errorMessageLabel.numberOfLines = 0
    errorMessageLabel.lineBreakMode = .byWordWrapping
  }
}
