//
//  TeamStandingsView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 21.06.2025..
//
import SofaAcademic
import SnapKit
import UIKit

class TeamStandingsView: BaseView {
  private let positionLabel: UILabel = .init()
  private let teamLabel: UILabel = .init()
  private let statsStackView: UIStackView = .init()
  private let positionLabelContainer: UIView = .init()

  func configure(with viewModel: StandingsRowViewModel?) {
    statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    if let viewModel = viewModel {
      positionLabel.text = viewModel.positionText
      teamLabel.text = viewModel.teamText
      statsStackView.spacing = viewModel.stackSpacing
      setupStatsLabels(statColumns: viewModel.statColumns)
    } else {
      positionLabel.text = nil
      teamLabel.text = nil
    }
  }

  override func addViews() {
    addSubview(positionLabelContainer)
    addSubview(teamLabel)
    addSubview(statsStackView)
    positionLabelContainer.addSubview(positionLabel)
  }

  override func setupConstraints() {
    positionLabelContainer.snp.makeConstraints { make in
      make.size.equalTo(24)
      make.leading.equalToSuperview().inset(8)
      make.top.bottom.equalToSuperview().inset(12)
    }

    positionLabel.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
    }

    teamLabel.snp.makeConstraints { make in
      make.centerY.equalTo(positionLabelContainer)
      make.leading.equalTo(positionLabelContainer.snp.trailing).offset(8)
      make.trailing.lessThanOrEqualTo(statsStackView.snp.leading).offset(-8)
    }

    statsStackView.snp.makeConstraints { make in
      make.centerY.equalTo(positionLabelContainer)
      make.trailing.equalToSuperview().inset(8)
    }
  }

  override func styleViews() {
    positionLabel.font = .bodyRegular
    positionLabel.textColor = .primary
    applyAdaptiveTextSizing(to: positionLabel)

    teamLabel.font = .bodyRegular
    teamLabel.textColor = .primary
    applyAdaptiveTextSizing(to: teamLabel)

    positionLabelContainer.layer.cornerRadius = 12
    positionLabelContainer.clipsToBounds = true
    positionLabelContainer.backgroundColor = .teamPostionBackground

    statsStackView.axis = .horizontal
  }

  private func setupStatsLabels(statColumns: [StatColumnInfo]) {
    for info in statColumns {
      let label = UILabel()
      label.text = info.value
      label.font = .bodyRegular
      label.textColor = .primary
      label.textAlignment = .center
      label.snp.makeConstraints { $0.width.equalTo(info.width) }
      applyAdaptiveTextSizing(to: label, minScale: 0.6)
      statsStackView.addArrangedSubview(label)
    }
  }

  private func applyAdaptiveTextSizing(
    to label: UILabel,
    minScale: CGFloat = 0.75,
    breakMode: NSLineBreakMode = .byTruncatingTail,
    shrinkText: Bool = true
  ) {
    label.adjustsFontSizeToFitWidth = shrinkText
    label.minimumScaleFactor = minScale
    label.lineBreakMode = breakMode
    label.numberOfLines = 1
  }
}
