//
//  ManagerView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 22.06.2025..
//
import SofaAcademic
import UIKit
import SnapKit

class ManagerView: BaseView {
  private let managerImageView: UIImageView = .init()
  private let managerNameLabel: UILabel = .init()
  private let managerCountryLabel: UILabel = .init()
  private let managerCountryImageView: UIImageView = .init()
  private let nameCountryStackView: UIStackView = .init()
  private let countryImageLabelContainer: UIView = .init()

  func configure(with viewModel: ManagerViewModel?) {
    if let viewModel = viewModel {
      managerImageView.image = .managerPlaceholder
      managerImageView.loadImage(from: viewModel.photoURL)
      managerNameLabel.text = viewModel.name
      managerCountryLabel.text = viewModel.countryName
      managerCountryImageView.image = .countryPlaceholder
      managerCountryImageView.loadCountryFlag(for: viewModel.countryName)
    } else {
      managerImageView.image = nil
      managerNameLabel.text = nil
      managerCountryLabel.text = nil
      managerCountryImageView.image = nil
    }
  }

  override func addViews() {
    addSubview(managerImageView)
    addSubview(nameCountryStackView)

    countryImageLabelContainer.addSubview(managerCountryLabel)
    countryImageLabelContainer.addSubview(managerCountryImageView)

    nameCountryStackView.addArrangedSubview(managerNameLabel)
    nameCountryStackView.addArrangedSubview(countryImageLabelContainer)
  }

  override func setupConstraints() {
    managerImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.leading.equalToSuperview().inset(16)
      make.top.equalToSuperview().inset(8)
      make.bottom.equalToSuperview().inset(8)
    }

    nameCountryStackView.snp.makeConstraints { make in
      make.centerY.equalTo(managerImageView)
      make.trailing.lessThanOrEqualToSuperview()
      make.leading.equalTo(managerImageView.snp.trailing).offset(16)
    }

    managerCountryImageView.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.leading.top.bottom.equalToSuperview()
    }

    managerCountryLabel.snp.makeConstraints { make in
      make.centerY.equalTo(managerCountryImageView)
      make.leading.equalTo(managerCountryImageView.snp.trailing).offset(4)
    }
  }

  override func styleViews() {
    nameCountryStackView.axis = .vertical

    managerNameLabel.font = .bodyRegular
    managerNameLabel.textColor = .primary

    managerCountryLabel.font = .bodyBold
    managerCountryLabel.textColor = .secondary

    managerCountryImageView.contentMode = .scaleAspectFill
    managerCountryImageView.layer.cornerRadius = 8
    managerCountryImageView.clipsToBounds = true

    managerImageView.contentMode = .scaleAspectFill
    managerImageView.layer.cornerRadius = 20
    managerImageView.clipsToBounds = true
  }
}
