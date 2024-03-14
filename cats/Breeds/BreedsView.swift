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
    @Query private var persistedBreeds: [LocalBreed]
    @State private var localBreeds: [LocalBreed] = []

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
                            NavigationLink(destination: DetailsView(breed: breed)) {
                                CardView(viewModel: CardViewModel(breed: breed),
                                         width: (geometry.size.width - 10) / 2,
                                         didTapFavourite: {
                                    handleFavourite(index: index)
                                })
                            }
                        }.frame(width: CardViewModel.Constants.height, height: CardViewModel.Constants.height)
                    }
                }   
                .scrollIndicators(.hidden)
            }
            .padding()
            .background(Color.white)
        }
        .accentColor(.black)
        .onAppear {
            viewModel.getBreeds {
                localBreeds = persistedBreeds
                guard persistedBreeds.isEmpty else { return }
                viewModel.localData.forEach { breed in
                    modelContext.insert(breed)
                }
            }
        }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                viewModel.searchBreed(query: searchText) { breeds in
                    localBreeds = breeds
                }
            }
    }
    
    func handleFavourite(index: Int) {

        let breed = localBreeds[index]
        breed.isFavorited.toggle()
        modelContext.insert(breed)
    }
}
