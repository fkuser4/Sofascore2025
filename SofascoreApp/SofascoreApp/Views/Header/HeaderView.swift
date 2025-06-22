//
//  HeaderView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 19.06.2025..
//
import UIKit
import SofaAcademic
import SnapKit

class HeaderView: BaseView {
  private let headerTitleLabel: UILabel = .init()
  private let headerImageView: UIImageView = .init()
  private let countryNameLabel: UILabel = .init()
  private let countryFlagImageView: UIImageView = .init()
  private let headerImageViewContainer: UIView = .init()
  private let titleContryStackView: UIStackView = .init()
  private let contryFlagNameContainer: UIView = .init()

  func configure(with headerViewModel: HeaderViewModel?) {
    if let headerViewModel = headerViewModel {
      headerTitleLabel.text = headerViewModel.title
      headerImageView.image = .leagueLogoPlaceholder
      headerImageView.loadImage(from: headerViewModel.imageURL)

      if let country = headerViewModel.country {
        contryFlagNameContainer.isHidden = false
        countryNameLabel.text = country
        countryFlagImageView.image = .countryPlaceholder
        countryFlagImageView.loadCountryFlag(for: country)
      }
    } else {
      headerTitleLabel.text = nil
      headerImageView.image = nil
      countryNameLabel.text = nil
      countryFlagImageView.image = nil
    }
  }

  override func addViews() {
    addSubview(headerImageViewContainer)
    addSubview(titleContryStackView)

    headerImageViewContainer.addSubview(headerImageView)

    contryFlagNameContainer.addSubview(countryFlagImageView)
    contryFlagNameContainer.addSubview(countryNameLabel)

    titleContryStackView.addArrangedSubview(headerTitleLabel)
    titleContryStackView.addArrangedSubview(contryFlagNameContainer)
  }

  override func styleViews() {
    self.backgroundColor = .primaryBackgroundColor

    countryFlagImageView.contentMode = .scaleAspectFill
    countryFlagImageView.layer.cornerRadius = 8
    countryFlagImageView.clipsToBounds = true

    contryFlagNameContainer.isHidden = true

    headerImageViewContainer.backgroundColor = .white
    headerImageViewContainer.layer.cornerRadius = 8

    headerTitleLabel.font = .screenHeadline
    headerTitleLabel.textColor = .white
    countryNameLabel.font = .primaryTitle
    countryNameLabel.textColor = .white

    titleContryStackView.axis = .vertical
    titleContryStackView.alignment = .leading
    titleContryStackView.spacing = 4
  }

  override func setupConstraints() {
    headerImageView.snp.makeConstraints { make in
      make.size.equalTo(40)
      make.edges.equalToSuperview().inset(8)
    }

    headerImageViewContainer.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.leading.equalToSuperview().inset(16)
    }

    titleContryStackView.snp.makeConstraints { make in
      make.centerY.equalTo(headerImageViewContainer)
      make.leading.equalTo(headerImageViewContainer.snp.trailing).offset(16)
    }

    countryFlagImageView.snp.makeConstraints { make in
      make.size.equalTo(16)
      make.top.bottom.leading.equalToSuperview()
    }

    countryNameLabel.snp.makeConstraints { make in
      make.leading.equalTo(countryFlagImageView.snp.trailing).offset(4)
      make.trailing.lessThanOrEqualToSuperview()
      make.centerY.equalTo(countryFlagImageView)
    }
  }
}
