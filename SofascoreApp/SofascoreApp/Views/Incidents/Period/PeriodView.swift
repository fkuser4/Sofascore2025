//
//  PeriodView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.06.2025..
//
import SnapKit
import UIKit
import SofaAcademic

class PeriodView: BaseView {
  private let periodDescriptionLabel: UILabel = .init()
  private let periodDescriptionContainer: UIView = .init()

  func configure(with periodViewModel: PeriodViewModel?) {
    if let periodViewModel = periodViewModel {
      periodDescriptionLabel.text = periodViewModel.periodDescription
    } else {
      periodDescriptionLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(periodDescriptionContainer)
    periodDescriptionContainer.addSubview(periodDescriptionLabel)
  }

  override func styleViews() {
    periodDescriptionLabel.font = .bodyBold
    periodDescriptionLabel.textColor = .primary
    periodDescriptionLabel.textAlignment = .center


    periodDescriptionContainer.backgroundColor = .periodIncidentBackground
    periodDescriptionContainer.layer.cornerRadius = 16
  }

  override func setupConstraints() {
    periodDescriptionLabel.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(4)
    }

    periodDescriptionContainer.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(8)
    }
  }
}
