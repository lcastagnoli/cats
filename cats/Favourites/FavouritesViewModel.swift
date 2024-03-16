//
//  FavouritesViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

import SwiftData

extension FavouritesView {

    @Observable
    final class FavouritesViewModel {

        // MARK: Properties
        var modelContext: ModelContext

        // MARK: Initializers
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        // MARK: Methods
        func removeFavourite(index: Int, _ favourites: [Favourite]) {
            
            modelContext.delete(favourites[index])
        }
    }
}
