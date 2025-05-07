//
//  DataPersistenceManager.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import UIKit
import CoreData

enum DatabaseError: Error {
  case deleteFailed
  case saveFailed
  case fetchFailed
}

final class DataPersistenceManager {
  static let shared = DataPersistenceManager()
  private let container: NSPersistentContainer

  private init() {
    container = NSPersistentContainer(name: "SofascoreModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }

  func saveEvents(_ events: [Event], completed: @escaping (Result<Void, DatabaseError>) -> Void) {
    container.performBackgroundTask { context in
      context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      for event in events {
        _ = EventEntity.fromDTO(event, in: context)
      }

      do {
        try context.save()
        completed(.success(()))
      } catch {
        completed(.failure(.saveFailed))
      }
    }
  }

  func fetchAllEvents(completed: @escaping (Result<[EventEntity], DatabaseError>) -> Void) {
    let context = container.viewContext
    context.perform {
      let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
      do {
        let entities = try context.fetch(request)
        completed(.success(entities))
      } catch {
        completed(.failure(.fetchFailed))
      }
    }
  }

  func fetchAllLeagues(completed: @escaping (Result<[LeagueEntity], DatabaseError>) -> Void) {
    let context = container.viewContext
    context.perform {
      let request: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
      do {
        let entities = try context.fetch(request)
        completed(.success(entities))
      } catch {
        completed(.failure(.fetchFailed))
      }
    }
  }

  func deleteAllObjects(completed: @escaping (Result<Void, DatabaseError>) -> Void) {
    container.performBackgroundTask { context in
      let model = self.container.managedObjectModel
      do {
        for entity in model.entities {
          guard let name = entity.name else { continue }
          let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: name)
          let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)
          deleteReq.resultType = .resultTypeObjectIDs
          let result = try context.execute(deleteReq) as? NSBatchDeleteResult
          if let ids = result?.result as? [NSManagedObjectID] {
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: ids]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self.container.viewContext])
          }
        }
        try context.save()
        completed(.success(()))
      } catch {
        completed(.failure(.deleteFailed))
      }
    }
  }

  private func saveContext () {
    let context = container.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
