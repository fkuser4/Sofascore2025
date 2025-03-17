//
//  LeagueTitleView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueTitleView: BaseView {
    
    private var countryLabel: UILabel = .init()
    private var leagueNameLabel: UILabel = .init()
    private var arrowImageView: UIImageView = .init()
    
    func configure(leagueName: String, country: String){
        countryLabel.text = country
        leagueNameLabel.text = leagueName
        arrowImageView.image = UIImage(named: "arrowRight")?.withRenderingMode(.alwaysTemplate)
    }
    
    override func addViews() {
        addSubview(countryLabel)
        addSubview(leagueNameLabel)
        addSubview(arrowImageView)
    }

    override func styleViews() {
        countryLabel.font = Fonts.bold(size: 14)
        countryLabel.textColor = Colors.textPrimary
        countryLabel.numberOfLines = 1
        countryLabel.lineBreakMode = .byTruncatingTail

        leagueNameLabel.font = Fonts.bold(size: 14)
        leagueNameLabel.textColor = Colors.textSecondary
        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.lineBreakMode = .byTruncatingTail
        
        arrowImageView.tintColor = Colors.textSecondary
    
    }

    override func setupConstraints() {
        countryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(10)
            $0.leading.equalTo(countryLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
            // Configure gesture recognizers
    }

    override func setupBinding() {
            // Set up bindings
    }
}
