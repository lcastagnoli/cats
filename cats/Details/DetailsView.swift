//
//  DetailsView.swift
//  cats
//
//  Created by Laryssa Castagnoli on 14/03/24.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct DetailsView: View {
    
    @State private var isFavorited = false

    // MARK: Properties
    @State private var viewModel: DetailsViewModel
    private var  details: String {
        "Origin: \(viewModel.breed.origin)\nTemperament: \(viewModel.breed.temperament)\nDescription: \(viewModel.breed.description)"
    }

    // MARK: Initializers
    init(modelContext: ModelContext, breed: BreedProtocol) {
        let viewModel = DetailsViewModel(modelContext: modelContext, breed: breed)
        _viewModel = State(initialValue: viewModel)
    }
    
    // MARK: UI
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack {
                    WebImage(url: URL(string: viewModel.breed.imageUrl))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.top)
                    Text(details)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                Button(action: {
                    viewModel.handleFavourite()
                }) {
                    Image(systemName: viewModel.isFavorited ? "star.fill" : "star")
                        .padding()
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.breed.name)
    }
}

extension DetailsView {

    @Observable
    class DetailsViewModel {

        // MARK: Properties
        var modelContext: ModelContext
        var favourites = [Favourite]()
        var breed: BreedProtocol
        var isFavorited: Bool { favourites.contains(where: { $0.id == breed.id }) }

        // MARK: Initializers
        init(modelContext: ModelContext, breed: BreedProtocol) {
            self.modelContext = modelContext
            self.breed = breed
            fetchData()
        }

        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<Favourite>(sortBy: [SortDescriptor(\.name)])
                favourites = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

        func handleFavourite() {
            
            if let favourite = favourites.first(where: { $0.id == breed.id }) {
                modelContext.delete(favourite)
            } else {
                if let onlineBreed = breed as? Breed {
                    modelContext.insert(Favourite(with: onlineBreed))
                } else if let localBreed = breed as? Favourite {
                    modelContext.insert(localBreed)
                }
            }
            fetchData()
        }
    }
}
