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

    var breedsPublisher: Published<[Breed]>.Publisher { get }
    func getBreeds()
}
final class BreedsViewModel {

    // MARK: Properties
    @Published var breeds: [Breed] = []
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
        breeds = response
    }
}

// MARK: - BreedsViewModelProtocol
extension BreedsViewModel: BreedsViewModelProtocol {

    var breedsPublisher: Published<[Breed]>.Publisher { $breeds }

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

