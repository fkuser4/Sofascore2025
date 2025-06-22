//
//  PlayerView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import SnapKit
import UIKit

class PlayerView: BaseView {
  private let playerImageView: UIImageView = .init()
  private let playerNameLabel: UILabel = .init()
  private let playerCountryLabel: UILabel = .init()
  private let playerCountryImageView: UIImageView = .init()
  private let nameCountryStackView: UIStackView = .init()
  private let countryImageLabelContainer: UIView = .init()

  func configure(with viewModel: PlayerViewModel?) {
    if let viewModel = viewModel {
      playerImageView.image = .playerPhotoPlaceholder
      playerImageView.loadImage(from: viewModel.photoURL)
      playerNameLabel.text = viewModel.name
      playerCountryLabel.text = viewModel.country
      playerCountryImageView.image = .countryPlaceholder
      playerCountryImageView.loadCountryFlag(for: viewModel.country)
    } else {
      playerImageView.image = nil
      playerNameLabel.text = nil
      playerCountryLabel.text = nil
      playerCountryImageView.image = nil
    }
  }

  override func addViews() {
    addSubview(playerImageView)
    addSubview(nameCountryStackView)

    countryImageLabelContainer.addSubview(playerCountryLabel)
    countryImageLabelContainer.addSubview(playerCountryImageView)

    nameCountryStackView.addArrangedSubview(playerNameLabel)
    nameCountryStackView.addArrangedSubview(countryImageLabelContainer)
  }

  override func setupConstraints() {
    playerImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.leading.equalToSuperview().inset(16)
      make.top.equalToSuperview().inset(8)
      make.bottom.equalToSuperview().inset(16)
    }

    nameCountryStackView.snp.makeConstraints { make in
      make.centerY.equalTo(playerImageView)
      make.trailing.lessThanOrEqualToSuperview()
      make.leading.equalTo(playerImageView.snp.trailing).offset(16)
    }

    playerCountryImageView.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.leading.top.bottom.equalToSuperview()
    }

    playerCountryLabel.snp.makeConstraints { make in
      make.centerY.equalTo(playerCountryImageView)
      make.leading.equalTo(playerCountryImageView.snp.trailing).offset(4)
    }
  }

  override func styleViews() {
    nameCountryStackView.axis = .vertical

    playerNameLabel.font = .bodyRegular
    playerNameLabel.textColor = .primary

    playerCountryLabel.font = .bodyBold
    playerCountryLabel.textColor = .secondary

    playerCountryImageView.contentMode = .scaleAspectFill
    playerCountryImageView.layer.cornerRadius = 8
    playerCountryImageView.clipsToBounds = true

    playerImageView.contentMode = .scaleAspectFill
    playerImageView.layer.cornerRadius = 20
    playerImageView.clipsToBounds = true
  }
}
