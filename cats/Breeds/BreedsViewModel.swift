//
//  BreedsViewModel.swift
//  cats
//
//  Created by Laryssa Castagnoli on 11/03/24.
//

import Network
import Combine
import Foundation

protocol BreedsViewModelProtocol: ObservableObject {

    var cardViewModels: [CardViewModel] { get }
    func getBreeds()
}
final class BreedsViewModel {

    // MARK: Properties
    @Published var cards: [CardViewModel] = []
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    private var service: BreedsServiceProtocol

    // MARK: Initializers
    init(service: BreedsServiceProtocol) {
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

    private func handle(response: [Breed]) {
        cards.append(contentsOf: response.map { CardViewModel(with: $0.image?.url, title: $0.name ?? "")})
    }
}

// MARK: - BreedsViewModelProtocol
extension BreedsViewModel: BreedsViewModelProtocol {

    var cardViewModels: [CardViewModel] { cards }

    func getBreeds() {

        service.breeds()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handle(completion: completion)
            }, receiveValue: { [weak self] response in
                self?.handle(response: response)
            })
            .store(in: &cancellables)
    }
}

