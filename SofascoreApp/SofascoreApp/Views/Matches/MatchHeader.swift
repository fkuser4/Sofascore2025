//
//  RoundHeader.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 20.06.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class MatchHeader: BaseView {
  private let titleLabel: UILabel = .init()

  func configure(title: String?) {
    if let title = title {
      titleLabel.text = title
    } else {
      titleLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(titleLabel)
  }

  override func styleViews() {
    titleLabel.font = .bodyBold
    titleLabel.textColor = .primary
  }

  override func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(24)
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(8)
      make.trailing.lessThanOrEqualToSuperview()
    }
  }
}
