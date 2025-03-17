//
//  TeamData.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.03.2025..
//
import UIKit

public struct TeamData{
    
    public let id: Int
    public let name: String
    public let logoUrl: String?

    public init(id: Int, name: String, logoUrl: String?) {
        self.id = id
        self.name = name
        self.logoUrl = logoUrl
    }
}
