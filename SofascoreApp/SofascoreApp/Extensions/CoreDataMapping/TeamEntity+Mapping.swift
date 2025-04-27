//
//  TeamEntity+Mapping.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import Foundation
import CoreData

extension TeamEntity {
  static func fromDTO(_ dto: Team, in context: NSManagedObjectContext) -> TeamEntity {
    let entity = TeamEntity(context: context)
    entity.id = Int64(dto.id)
    entity.name = dto.name
    entity.logoUrl = dto.logoUrl

    return entity
  }
}
