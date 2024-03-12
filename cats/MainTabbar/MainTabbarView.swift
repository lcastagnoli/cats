//
//  MainTabbarView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import Network

struct MainTabbarView: View {

    var body: some View {
            TabView {
                BreedsView(viewModel: BreedsViewModel(service: BreedsService(service: Newtork(session: URLSession.shared))))
                    .tabItem {
                        Label("Breeds", systemImage: "text.book.closed")
                    }

                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "star")
                    }
            }
    }
}

#Preview {
    MainTabbarView()
}
