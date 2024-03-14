//
//  FavouritesView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData

struct FavouritesView<ViewModel: FavouritesViewModelProtocol>: View {

    // MARK: Properties
    @ObservedObject private var viewModel: ViewModel
    @State var gridLayout: [GridItem] = [ GridItem(.flexible()), GridItem(.flexible())]
    @Query private var breeds: [LocalBreed]
    @SwiftUI.Environment(\.modelContext) private var modelContext

    // MARK: Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                        ForEach(Array(breeds.filter { $0.isFavorited }.enumerated()), id: \.offset) { index, breed in
                            CardView(viewModel: CardViewModel(breed: breed),
                                     width: (geometry.size.width - 10) / 2,
                                     didTapFavourite: {
                                breed.isFavorited = false
                                modelContext.insert(breed)
                            })
                        }.frame(width: CardViewModel.Constants.height, height: CardViewModel.Constants.height)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            .background(Color.white)
        }
    }
}
