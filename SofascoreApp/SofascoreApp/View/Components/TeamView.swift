//
//  TeamView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.03.2025..
//

import UIKit
import SofaAcademic
import SnapKit

class TeamView: BaseView {
    
    private var teamLogoImageView: UIImageView = .init()
    private var teamNameLabel: UILabel = .init()
    
    func configure(teamLogo: UIImage, teamName: String, textColor: UIColor){
        teamLogoImageView.image = teamLogo
        teamNameLabel.text = teamName
        teamNameLabel.textColor = textColor
    }
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }

    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(teamLogoImageView.snp.width)
        }
        
        teamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(teamLogoImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    override func styleViews() {
        teamLogoImageView.contentMode = .scaleAspectFit
            
        teamNameLabel.font = Fonts.regular(size: 14)
        teamNameLabel.numberOfLines = 1
        teamNameLabel.lineBreakMode = .byTruncatingTail
    }

    override func setupGestureRecognizers() {
            // Configure gesture recognizers
    }

    override func setupBinding() {
            // Set up bindings
    }
}
