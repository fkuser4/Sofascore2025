//
//  EmptyStateView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 31.03.2025..
//
import UIKit
import SnapKit

final class EmptyStateView: UIView {
  private let messageLabel = UILabel()

  init(message: String) {
    super.init(frame: .zero)
    setup(message: message)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup(message: String) {
    addSubview(messageLabel)
    messageLabel.text = message
    messageLabel.textColor = .secondary
    messageLabel.font = .bodyRegular
    messageLabel.textAlignment = .center

    messageLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(32)
    }
  }
}
