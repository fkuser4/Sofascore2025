//
//  CountryEntity+Mapping.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import Foundation
import CoreData

extension CountryEntity {
  static func fromDTO(_ dto: Country, in context: NSManagedObjectContext) -> CountryEntity {
    let entity = CountryEntity(context: context)
    entity.id = Int64(dto.id)
    entity.name = dto.name

    return entity
  }
}
