//
//  Amex_Rewards_TrackerApp.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

@main
struct Amex_Rewards_TrackerApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            FullTabPage()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
