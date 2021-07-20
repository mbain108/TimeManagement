//
//  TimeManagementApp.swift
//  TimeManagement
//
//  Created by Melissa Bain on 7/20/21.
//

import SwiftUI

@main
struct TimeManagementApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
