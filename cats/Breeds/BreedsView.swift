//
//  BreedsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import SwiftUI
import SwiftData

struct BreedsView<ViewModel: BreedsViewModelProtocol>: View {

    // MARK: Properties
    @ObservedObject private var viewModel: ViewModel
    @State var gridLayout: [GridItem] = [ GridItem(.flexible()), GridItem(.flexible())]
    @State private var searchText = ""
    @SwiftUI.Environment(\.modelContext) private var modelContext
    @SwiftUI.Environment(\.isSearching) var isSearching
    @Query private var localBreeds: [LocalBreed]

    // MARK: Initializers
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                        ForEach(Array(localBreeds.enumerated()), id: \.offset) { index, breed in
                            CardView(viewModel: CardViewModel(breed: breed),
                                     width: (geometry.size.width - 10) / 2,
                                     didTapFavourite: {
                                handleFavourite(index: index)
                            })
                        }.frame(width: CardViewModel.Constants.height, height: CardViewModel.Constants.height)
                    }
                }   
                .scrollIndicators(.hidden)
            }
            .padding()
            .background(Color.white)
        }
        .onAppear {
            viewModel.getBreeds {
                guard localBreeds.isEmpty else { return }
                viewModel.localData.forEach { breed in
                    modelContext.insert(breed)
                }
            }
        }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.searchBreed(query: searchText)
            }
    }
    
    func handleFavourite(index: Int) {

        let breed = localBreeds[index]
        if localBreeds.contains(where: { $0.id == breed.id && $0.isFavorited}) {
            breed.isFavorited = false
            modelContext.insert(breed)
        } else {
            breed.isFavorited = true
            modelContext.insert(breed)
        }
    }
}
