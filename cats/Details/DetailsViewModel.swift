//
//  DetailsViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

import SwiftData
import SwiftUI

extension DetailsView {

    @Observable
    final class DetailsViewModel {

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
