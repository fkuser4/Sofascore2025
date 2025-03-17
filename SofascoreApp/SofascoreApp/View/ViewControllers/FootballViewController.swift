//
//  ViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 09.03.2025..
//

import UIKit
import SnapKit

class FootballViewController: UIViewController {
    
    private let leagueHeaderViewModel = LeagueHeaderViewModel()
    private let eventViewModel = EventViewModel()
    private let leagueHeaderView = LeagueHeaderView()
    private let eventsStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        addLeagueViews()
        setupConstraints()
    }
    
    private func setupUI() {
        eventsStackView.axis = .vertical
        eventsStackView.spacing = 8
        eventsStackView.alignment = .fill
        eventsStackView.distribution = .equalSpacing 

        let leagueData = leagueHeaderViewModel.getLeagueHeaderByName(leagueName: .laliga)
            
        let leagueLogo = leagueHeaderViewModel.fetchLeagueLogo(from: leagueData.logoUrl)
            
        leagueHeaderView.configure(leagueData: leagueData, leagueLogo: leagueLogo)

        if var events = eventViewModel.getEventsByName(leagueName: .laliga) {
            events.sort { $0.startTimestamp < $1.startTimestamp }
            for eventData in events {
                
                let eventView = EventView()
                let homeTextColor = eventViewModel.getTeamTextColor(eventData: eventData, isHomeTeam: true)
                let awayTextColor = eventViewModel.getTeamTextColor(eventData: eventData, isHomeTeam: false)
                let homeScoreTextColor = eventViewModel.getScoreTextColor(eventData: eventData, isHomeScore: true)
                let awayScoreTextColor = eventViewModel.getScoreTextColor(eventData: eventData, isHomeScore: false)
                let matchTime = eventViewModel.getMatchTimeString(from: eventData.startTimestamp)
                let statusText = eventViewModel.getMatchStatusText(eventData: eventData)
                let statusTextColor = eventViewModel.getTimeTextColor(eventData: eventData)
                
                eventView.configure(eventData: eventData,
                                    homeTeamLogo: eventViewModel.fetchTeamLogo(from: eventData.homeTeam.logoUrl)!,
                                    awayTeamLogo: eventViewModel.fetchTeamLogo(from: eventData.awayTeam.logoUrl)!,
                                    homeTeamTextColor: homeTextColor,
                                    awayTeamTextColor: awayTextColor,
                                    homeScoreTextColor: homeScoreTextColor,
                                    awayScoreTextColor: awayScoreTextColor,
                                    matchTime: matchTime,
                                    statusText: statusText,
                                    statusTextColor: statusTextColor)
                
                eventsStackView.addArrangedSubview(eventView)
                
                eventView.snp.makeConstraints { make in
                    make.height.equalTo(45)
                }
            }
        }
    }
    
    private func setupConstraints() {
        leagueHeaderView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        eventsStackView.snp.makeConstraints {
                $0.top.equalTo(leagueHeaderView.snp.bottom)
                $0.leading.trailing.equalTo(view).inset(16)
                $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
            }
    }
    
    private func addLeagueViews() {
        view.addSubview(leagueHeaderView)
        view.addSubview(eventsStackView)
    }
    
}

