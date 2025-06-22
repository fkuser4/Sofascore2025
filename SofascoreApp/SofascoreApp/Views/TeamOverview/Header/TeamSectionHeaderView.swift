//
//  TeamSectionHeaderView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class TeamSectionHeaderView: BaseView {
  private let titleLabel: UILabel = .init()

  func configure(with viewModel: TeamSectionHeaderViewModel?) {
    if let viewModel = viewModel {
      titleLabel.text = viewModel.title
    } else {
      titleLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(titleLabel)
  }

  override func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(12)
    }
  }

  override func styleViews() {
    titleLabel.font = .tournamentDetailsButton
    titleLabel.textColor = .primary
  }
}
