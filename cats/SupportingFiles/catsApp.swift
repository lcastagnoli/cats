//
//  catsApp.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData
import Network

@main
struct catsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Breed.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainTabbarView()
        }
        .modelContainer(sharedModelContainer)
    }
}
