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
        leagueLogoImageView.loadImage(from: leagueHeaderViewModel.logoURL)
        leagueTitleView.configure(leagueName: leagueHeaderViewModel.leagueName, country: leagueHeaderViewModel.countryName)
    }
    
    override func addViews() {
        addSubview(leagueLogoImageView)
        addSubview(leagueTitleView)
    }
    
    override func setupConstraints() {
        leagueLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(32)
        }
        
        leagueTitleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(32)
            $0.width.equalTo(151)
            $0.height.equalTo(24)
        }
    }
}
