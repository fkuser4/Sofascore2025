//
//  LeagueViewModel.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//

import Foundation
import UIKit
import SofaAcademic

class LeagueHeaderViewModel {
    private var homeworkDataSource = Homework2DataSource()
    
    func getLeagueHeaderByName(leagueName: LeagueNames) -> LeagueData {
        let league: League
        
        switch leagueName {
        case .laliga:
            league = homeworkDataSource.laLigaLeague()
        default:
            league = homeworkDataSource.laLigaLeague()
        }
        
        return parseLeagueData(from: league)
    }
    
    private func parseLeagueData(from league: League) -> LeagueData {
        let id = league.id
        let name = league.name
        let country = league.country?.name ?? "Unknown"
        let logoUrl = league.logoUrl
        
        return LeagueData(id: id, name: name, country: country, logoUrl: logoUrl)
    }

    func fetchLeagueLogo(from urlString: String?) -> UIImage? {
        guard let urlString = urlString, let url = URL(string: urlString),
              let imageData = try? Data(contentsOf: url) else {
            return UIImage(named: "placeholder")
        }
        return UIImage(data: imageData)
    }
}
