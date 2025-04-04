//
//  TimeView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.03.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class TimeView: BaseView {
  private let statusLabel: UILabel = .init()
  private let timeLabel: UILabel = .init()

  func configure(matchTime: String?, statusText: String?, statusTextColor: UIColor?) {
    timeLabel.text = matchTime

    statusLabel.text = statusText
    statusLabel.textColor = statusTextColor
  }

  override func addViews() {
    addSubview(statusLabel)
    addSubview(timeLabel)
  }

  override func styleViews() {
    statusLabel.font = .bodyLight
    statusLabel.textAlignment = .center

    timeLabel.font = .bodyLight
    timeLabel.textColor = .secondary
    timeLabel.textAlignment = .center
  }

  override func setupConstraints() {
    timeLabel.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(4)
    }

    statusLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(4)
    }
  }
}
