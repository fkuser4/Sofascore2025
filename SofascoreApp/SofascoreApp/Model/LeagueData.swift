//
//  LeagueData.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 16.03.2025..
//
import UIKit

public struct LeagueData{

    public let id: Int
    public let name: String
    public let country: String
    public let logoUrl: String?

    public init(
        id: Int,
        name: String,
        country: String,
        logoUrl: String?
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.logoUrl = logoUrl
    }

}
