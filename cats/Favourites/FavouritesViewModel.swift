//
//  FavouritesViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import Network
import Combine
import Foundation

protocol FavouritesViewModelProtocol: ObservableObject {

    var cardViewModels: [CardViewModel] { get }
    func getFavourites()
}
final class FavouritesViewModel {

    // MARK: Properties
    @Published var cards: [CardViewModel] = []
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    private var service: FavouritesServiceProtocol

    // MARK: Initializers
    init(service: FavouritesServiceProtocol) {
        self.service = service
    }
    
    // MARK: Methods
    private func handle(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error.localizedDescription)
        case .finished:
            break
        }
    }

    private func handle(response: [Favourite]) {
        cards.append(contentsOf: response.map { CardViewModel(with: $0.image?.url, title: $0.subID ?? "")})
    }
}

// MARK: - FavouritesViewModelProtocol
extension FavouritesViewModel: FavouritesViewModelProtocol {

    var cardViewModels: [CardViewModel] { cards }

    func getFavourites() {

        service.favourites()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handle(completion: completion)
            }, receiveValue: { [weak self] response in
                self?.handle(response: response)
            })
            .store(in: &cancellables)
    }
}
