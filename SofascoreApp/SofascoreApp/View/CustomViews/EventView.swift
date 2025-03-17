//
//  EventView.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//

import Foundation
import SofaAcademic
import UIKit
import SnapKit

class EventView : BaseView {
    private let homeTeam: TeamView = .init()
    private let awayTeam: TeamView = .init()
    private let timeView: TimeView = .init()
    private var homeScore = UILabel()
    private var awayScore = UILabel()
    private let leftBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textSecondary
        return view
    }()
    
    func configure(eventData: EventData, homeTeamLogo: UIImage, awayTeamLogo: UIImage,
                   homeTeamTextColor: UIColor, awayTeamTextColor: UIColor,
                   homeScoreTextColor: UIColor, awayScoreTextColor: UIColor, matchTime: String,
                   statusText: String, statusTextColor: UIColor) {
        
        homeScore.text = eventData.homeScore.map { "\($0)" } ?? ""
        awayScore.text = eventData.awayScore.map { "\($0)" } ?? ""
        homeScore.textColor = homeScoreTextColor
        awayScore.textColor = awayScoreTextColor
        
        homeTeam.configure(teamLogo: homeTeamLogo, teamName: eventData.homeTeam.name, textColor: homeTeamTextColor)
        awayTeam.configure(teamLogo: awayTeamLogo, teamName: eventData.awayTeam.name, textColor: awayTeamTextColor)
        timeView.configure(matchTime: matchTime, statusText: statusText, statusTextColor: statusTextColor)
    }
    
    override func addViews() {
        addSubview(homeTeam)
        addSubview(awayTeam)
        addSubview(timeView)
        addSubview(homeScore)
        addSubview(awayScore)
        addSubview(leftBorderView)
    }

    override func styleViews() {
        homeScore.font = Fonts.regular(size: 14)
        awayScore.font = Fonts.regular(size: 14)
        
        let leftBorder = CALayer()
        leftBorder.backgroundColor = Colors.textPrimary.cgColor
        leftBorder.frame = CGRect(x: 0, y: 0, width: 4, height: bounds.height)
            
        layer.addSublayer(leftBorder)
    }

    override func setupConstraints() {
        
        timeView.snp.makeConstraints { make in
            make.top.leading.height.equalToSuperview()
            make.width.equalTo(45)
        }
        
        leftBorderView.snp.makeConstraints { make in
            make.leading.equalTo(timeView.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }
        
        homeTeam.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(timeView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        awayTeam.snp.makeConstraints { make in
            make.leading.equalTo(timeView.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(homeTeam.snp.bottom)
        }
        
        homeScore.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(30)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(homeTeam)
        }
        
        awayScore.snp.makeConstraints { make in
            make.top.equalTo(homeTeam.snp.bottom)
            make.width.equalTo(30)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(awayTeam)
        }
        
        
    }

    override func setupGestureRecognizers() {
            // Configure gesture recognizers
    }

    override func setupBinding() {
            // Set up bindings
    }
    
}
