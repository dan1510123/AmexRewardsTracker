//
//  Persistence.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "AmexRewards")
        
        container.loadPersistentStores  { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
