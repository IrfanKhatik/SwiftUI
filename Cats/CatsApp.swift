//
//  CatsApp.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import SwiftUI

@main
struct CatsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
