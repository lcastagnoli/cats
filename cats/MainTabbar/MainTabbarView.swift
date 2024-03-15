//
//  MainTabbarView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import Network

struct MainTabbarView: View {

    private let session = URLSession.shared
    private let network: Newtork
    @SwiftUI.Environment(\.modelContext) var modelContext

    init() {
        self.network = Newtork(session: self.session)
    }

    var body: some View {
            TabView {
                BreedsView(modelContext: modelContext, service: BreedsService(service: network))
                    .tabItem {
                        Label("Breeds", systemImage: "text.book.closed")
                    }

                FavouritesView(modelContext: modelContext)
                    .tabItem {
                        Label("Favourites", systemImage: "star")
                    }
            }
            .tint(.black)
    }
}
