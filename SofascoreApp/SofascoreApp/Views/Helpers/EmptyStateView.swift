//
//  EmptyStateView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 31.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class EmptyStateView: BaseView {
  private let messageLabel = UILabel()

  public func setMessageText(_ text: String?) {
    if let text = text {
      messageLabel.text = text
    }
  }

  override func addViews() {
    addSubview(messageLabel)
  }

  override func setupConstraints() {
    messageLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(70)
      $0.leading.trailing.equalToSuperview().inset(32)
    }
  }

  override func styleViews() {
    messageLabel.textColor = .secondary
    messageLabel.font = .bodyRegular
    messageLabel.textAlignment = .center
    messageLabel.numberOfLines = 0
  }
}
