//
//  PersistentController.swift
//  Data
//
//  Created by ali alaa on 02/02/2025.
//

import CoreData

struct PersistentController {
    // MARK: - Properties
    public static let shared = PersistentController()
    let container: NSPersistentContainer
    
    // MARK: - Life cycle
    init(inMemory: Bool = false) {
        let bundle = Bundle.module
        let modelURL = bundle.url(forResource: CoreDataModel.movie.rawValue, withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        container = NSPersistentContainer(name: CoreDataModel.movie.rawValue, managedObjectModel: managedObjectModel)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("CoreData error: \(error.localizedDescription)")
            }
        }
    }
}
