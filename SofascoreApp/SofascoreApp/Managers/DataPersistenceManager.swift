//
//  DataPersistenceManager.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 26.04.2025..
//
import UIKit
import CoreData

final class DataPersistenceManager {
  static let shared = DataPersistenceManager()
  private let container: NSPersistentContainer

  private init() {
    container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer // swiftlint:disable:this force_cast

    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }

  func saveEventWith(model: Event, completed: @escaping (Result<Void, DatabaseError>) -> Void) {
    container.performBackgroundTask { context in
      context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      _ = EventEntity.fromDTO(model, in: context)
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
}

enum DatabaseError: Error {
  case deleteFailed
  case saveFailed
  case fetchFailed
}
