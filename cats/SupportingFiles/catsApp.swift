//
//  catsApp.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData

@main
struct catsApp: App {

    var body: some Scene {
        WindowGroup {
            MainTabbarView()
        }
        .modelContainer(for: Favourite.self)
    }
}
