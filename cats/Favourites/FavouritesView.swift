//
//  FavouritesView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {

    // MARK: Properties
    @State private var viewModel: FavouritesViewModel
    @State var gridLayout: [GridItem] = [ GridItem(.flexible()), GridItem(.flexible())]
    @Query private var favourites: [Favourite]

    // MARK: Initializers
    init(modelContext: ModelContext) {
        let viewModel = FavouritesViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }

    // MARK: UI
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: Constants.padding) {
                    ForEach(Array(favourites.enumerated()), id: \.offset) { index, breed in
                        NavigationLink(destination: DetailsView(modelContext: viewModel.modelContext, breed: breed)) {
                            CardView(breed: breed,
                                     isFavorite: true) {
                                viewModel.removeFavourite(index: index, favourites)
                            }.frame(minWidth: .zero, maxWidth: .infinity)
                        }
                    }.frame(height: Constants.height)
                }.padding(.all, 10)
            }
            .background(Color.white)
            .scrollIndicators(.hidden)
        }
        .accentColor(.black)
    }
}
