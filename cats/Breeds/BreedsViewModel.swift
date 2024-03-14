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

    var localData: [LocalBreed] { get }
    func searchBreed(query: String, completion: @escaping ([LocalBreed]) -> Void)
    func getBreeds(completion: @escaping () -> Void)
}
final class BreedsViewModel {

    // MARK: Properties
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    private var service: BreedsServiceProtocol
    private var response: [Breed] = []
    @Published var breeds: [LocalBreed] = []

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
        self.response = response
        breeds = response.map { LocalBreed(with: $0) }
    }
}

// MARK: - BreedsViewModelProtocol
extension BreedsViewModel: BreedsViewModelProtocol {
    
    var localData: [LocalBreed] { breeds }

    func getBreeds(completion: @escaping () -> Void) {
        
        service.breeds()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] receivedCompletion in
                self?.handle(completion: receivedCompletion)
            }, receiveValue: { [weak self] response in
                self?.handle(response: response)
                completion()
            })
            .store(in: &cancellables)
    }
    
    func searchBreed(query: String, completion: @escaping ([LocalBreed]) -> Void) {

        service.searchBreed(with: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handle(completion: completion)
            }, receiveValue: { response in
                let localBreeds = response.map { LocalBreed(with: $0 )}
                completion(localBreeds)
            })
            .store(in: &cancellables)
    }
}

