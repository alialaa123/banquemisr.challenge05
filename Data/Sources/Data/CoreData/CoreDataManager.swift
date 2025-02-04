//
//  CoreDataManager.swift
//  Data
//
//  Created by ali alaa on 01/02/2025.
//

import Foundation
import CoreData
import Domain

public final class CoreDataManager: Sendable {
    // MARK: - Properties
    public static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    // MARK: - Life cycle
    private init() {
        persistentContainer = PersistentController.shared.container
    }
    
    // MARK: - Methods
    public func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) async throws -> [T] {
        let context = persistentContainer.viewContext
        return try await context.perform {
            let data = try context.fetch(request)
            guard !data.isEmpty else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            return data
        }
    }
    
    public func save() async throws {
        let context = persistentContainer.viewContext
        try await context.perform {
            if context.hasChanges {
                try context.save()
            }
        }
    }
    
    public func delete(_ object: NSManagedObject) async throws {
        let context = persistentContainer.viewContext
        try await context.perform {
            context.delete(object)
            try context.save()
        }
    }
    
    public func insert<T: NSManagedObject>(_ type: T.Type) async throws -> T? {
        let context = persistentContainer.viewContext
        return try await context.perform {
            let newObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: type), into: context) as? T
            try context.save()
            return newObject
        }
    }
}
