//
//  LeagueView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueHeaderView : BaseView {
    private var leagueLogoImageView: UIImageView = .init()
    private var leagueTitleView: LeagueTitleView = .init()
    
    func configure(leagueData: LeagueData, leagueLogo: UIImage?){
        leagueLogoImageView.image = leagueLogo ?? UIImage(named: "placeholder")
        //leagueLogoImageView.backgroundColor = .black
        leagueTitleView.configure(leagueName: leagueData.name, country: leagueData.country)
       
    }
    
    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueTitleView)
    }

    override func styleViews() {
            // Apply styles to your subviews
    }

    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(12)
                    $0.leading.equalToSuperview().inset(16)
                    $0.width.height.equalTo(32)
                }
        leagueTitleView.snp.makeConstraints {
                   $0.centerY.equalTo(leagueLogoImageView)
                   $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
                   $0.trailing.equalToSuperview().inset(16)
               }
    }

    override func setupGestureRecognizers() {
            // Configure gesture recognizers
    }

    override func setupBinding() {
            // Set up bindings
    }
    
}
