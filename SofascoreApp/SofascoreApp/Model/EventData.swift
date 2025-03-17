//
//  EventData.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.03.2025..
//

public struct EventData {

    public let id: Int
    public let homeTeam: TeamData
    public let awayTeam: TeamData
    public let status: String
    public let startTimestamp: Int
    public let homeScore: Int?
    public let awayScore: Int?

    public init(
        id: Int,
        homeTeam: TeamData,
        awayTeam: TeamData,
        status: String,
        startTimestamp: Int,
        homeScore: Int? = nil,
        awayScore: Int? = nil
    ) {
        self.id = id
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.status = status
        self.startTimestamp = startTimestamp
        self.homeScore = homeScore
        self.awayScore = awayScore
    }

}
