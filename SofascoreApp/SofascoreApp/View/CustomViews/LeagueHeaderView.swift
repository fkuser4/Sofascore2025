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
    
    func configure(with leagueHeaderViewModel: LeagueHeaderViewModel){
        
        leagueLogoImageView.loadImage(from: leagueHeaderViewModel.logoUrlString)
        leagueTitleView.configure(leagueName: leagueHeaderViewModel.leagueName, country: leagueHeaderViewModel.countryName)
    }
    
    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueTitleView)
    }
    
    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(12)
                    $0.leading.equalToSuperview().inset(20)
                    $0.width.height.equalTo(32)
                }
        leagueTitleView.snp.makeConstraints {
                   $0.centerY.equalTo(leagueLogoImageView)
                   $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
                   $0.trailing.equalToSuperview().inset(16)
               }
    }
}
