//
//  LeagueEntity+Mapping.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import Foundation
import CoreData

extension LeagueEntity {
  static func fromDTO(_ dto: League, in context: NSManagedObjectContext) -> LeagueEntity {
    let entity = LeagueEntity(context: context)
    entity.id = Int64(dto.id)
    entity.name = dto.name
    entity.logoUrl = dto.logoUrl
    entity.country = CountryEntity.fromDTO(dto.country, in: context)
    entity.id = Int64(dto.id)

    return entity
  }
}
