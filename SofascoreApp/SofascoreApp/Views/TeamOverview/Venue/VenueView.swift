//
//  VenueView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class VenueView: BaseView {
  private let stadiumLabel: UILabel = .init()
  private let stadiumNameLabel: UILabel = .init()


  func configure(with viewModel: VenueViewModel?) {
    if let viewModel = viewModel {
      stadiumNameLabel.text = viewModel.name
    } else {
      stadiumLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(stadiumLabel)
    addSubview(stadiumNameLabel)
  }

  override func setupConstraints() {
    stadiumLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.equalToSuperview().inset(16)
    }

    stadiumNameLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16)
      make.centerY.equalTo(stadiumLabel)
    }
  }

  override func styleViews() {
    stadiumLabel.text = "Stadium"
    stadiumLabel.font = .bodyRegular
    stadiumLabel.textColor = .primary

    stadiumNameLabel.font = .bodyRegular
    stadiumNameLabel.textColor = .primary
  }
}
