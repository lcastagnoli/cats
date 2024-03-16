//
//  BreedsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData

struct BreedsView: View {

    // MARK: Properties
    @State private var viewModel: BreedsViewModel
    @State private var searchText = ""
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity)),
                                          GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]
    @Query private var favourites: [Favourite]

    // MARK: Initializers
    init(modelContext: ModelContext, service: BreedsServiceProtocol) {
        let viewModel = BreedsViewModel(modelContext: modelContext, service: service)
        _viewModel = State(initialValue: viewModel)
    }

    // MARK: UI
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: Constants.padding) {
                    ForEach(Array(viewModel.breeds.enumerated()), id: \.offset) { index, breed in
                        NavigationLink(destination: DetailsView(modelContext: viewModel.modelContext, breed: breed)) {
                            CardView(breed: breed,
                                     isFavorite: favourites.contains(where: { $0.id == breed.id })) {
                                viewModel.handleFavourite(index: index, favourites)
                            }.frame(minWidth: .zero, maxWidth: .infinity)
                        }
                    }
                    .frame(height: Constants.height)
                }.padding(.all, Constants.padding)
            }
            .scrollIndicators(.hidden)
            .background(Color.white)
        }
        .accentColor(.black)
        .onAppear {
            viewModel.getBreeds()
        }
        .searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.searchBreed(query: searchText)
            }
            .onChange(of: searchText, { old, new in
                guard new.isEmpty else { return }
                viewModel.getBreeds()
            })
    }
}
