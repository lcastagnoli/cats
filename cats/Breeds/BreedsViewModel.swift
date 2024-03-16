//
//  BreedsViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

import Network
import Combine
import Foundation
import SwiftData

extension BreedsView {
    
    @Observable
    final class BreedsViewModel {
        
        // MARK: Properties
        var modelContext: ModelContext
        var breeds = [BreedProtocol]()
        private var service: BreedsServiceProtocol
        private var cancellables = Set<AnyCancellable>()
        
        // MARK: Initializers
        init(modelContext: ModelContext, service: BreedsServiceProtocol) {
            self.modelContext = modelContext
            self.service = service
        }
        
        
        // MARK: Methods
        func handleFavourite(index: Int, _ favourites: [Favourite]) {
            
            if let favourite = favourites.first(where: { $0.id == breeds[index].id }) {
                modelContext.delete(favourite)
            } else {
                if let onlineBreed = breeds[index] as? Breed {
                    modelContext.insert(Favourite(with: onlineBreed))
                }
            }
        }
        
        func getBreeds() {
            
            service.breeds()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] receivedCompletion in
                    self?.handle(completion: receivedCompletion)
                }, receiveValue: { [weak self] response in
                    self?.handle(response: response)
                })
                .store(in: &cancellables)
        }
        
        func searchBreed(query: String) {
            
            service.searchBreed(with: query)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.handle(completion: completion)
                }, receiveValue: { [weak self] response in
                    self?.handle(response: response)
                })
                .store(in: &cancellables)
        }
        
        private func handle(completion: Subscribers.Completion<Error>) {
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        }
        
        private func handle(response: [Breed]) {
            breeds = response
        }
    }
}

