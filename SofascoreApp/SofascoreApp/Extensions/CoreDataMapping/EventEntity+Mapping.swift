//
//  EventEntity+Mapping.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import Foundation
import CoreData

extension EventEntity {
  static func fromDTO(_ dto: Event, in context: NSManagedObjectContext) -> EventEntity {
    let entity = EventEntity(context: context)
    entity.id = Int64(dto.id)
    entity.startTimestamp = Int64(dto.startTimestamp)
    entity.status = dto.status.rawValue
    entity.awayScore = dto.awayScore as NSNumber?
    entity.homeScore = dto.homeScore as NSNumber?
    entity.league = LeagueEntity.fromDTO(dto.league, in: context)
    entity.homeTeam = TeamEntity.fromDTO(dto.homeTeam, in: context)
    entity.awayTeam = TeamEntity.fromDTO(dto.awayTeam, in: context)

    return entity
  }
}
