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

    init() {
        self.network = Newtork(session: self.session)
    }

    var body: some View {
            TabView {
                BreedsView(viewModel: BreedsViewModel(service: BreedsService(service: network)))
                    .tabItem {
                        Label("Breeds", systemImage: "text.book.closed")
                    }

                FavouritesView(viewModel: FavouritesViewModel(service: FavouritesService(service: network)))
                    .tabItem {
                        Label("Favourites", systemImage: "star")
                    }
            }
    }
}

#Preview {
    MainTabbarView()
}
