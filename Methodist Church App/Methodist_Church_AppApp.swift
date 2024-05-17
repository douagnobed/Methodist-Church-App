//
//  Methodist_Church_AppApp.swift
//  Methodist Church App
//
//  Created by Q002 on 09/03/2024.
//

import SwiftUI

@main
struct Methodist_Church_AppApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
