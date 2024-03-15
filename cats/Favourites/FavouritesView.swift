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

    // MARK: Initializers
    init(modelContext: ModelContext) {
        let viewModel = FavouritesViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }

    // MARK: UI
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(Array(viewModel.favourites.enumerated()), id: \.offset) { index, breed in
                        NavigationLink(destination: DetailsView(modelContext: viewModel.modelContext, breed: breed)) {
                            CardView(breed: breed,
                                     isFavorite: true) {
                                viewModel.removeFavourite(index: index)
                            }.frame(minWidth: .zero, maxWidth: .infinity)
                        }
                    }.frame(height: Constants.height)
                }.padding(.all, 10)
            }
            .background(Color.white)
            .scrollIndicators(.hidden)
        }
        .accentColor(.black)
        .onAppear {
            viewModel.fetchData()
        }
    }
}

extension FavouritesView {

    @Observable
    class FavouritesViewModel {

        // MARK: Properties
        var modelContext: ModelContext
        var favourites = [Favourite]()

        // MARK: Initializers
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }

        // MARK: Methods
        func removeFavourite(index: Int) {
            
            modelContext.delete(favourites[index])
            fetchData()
        }

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Favourite>(sortBy: [SortDescriptor(\.name)])
                favourites = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
    }
}
