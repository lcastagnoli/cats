//
//  FakeBreedsService.swift
//  catsTests
//
//  Created by Laryssa Castagnoli on 15/03/24.
//

import Combine
@testable import cats

final class FakeBreedsService: BreedsServiceProtocol {

    // MARK: Expectations
    private var breedsExpectation: [cats.Breed]
    private var searchBreedsExpectation: [cats.Breed]

    // MARK: Initializers
    init(breedsExpectation: [cats.Breed] = [],
         searchBreedsExpectation: [cats.Breed] = []) {
        
        self.breedsExpectation = breedsExpectation
        self.searchBreedsExpectation = searchBreedsExpectation
    }
    
    // MARK: Methods
    func searchBreed(with query: String) -> AnyPublisher<[cats.Breed], Error> {
        
        return Just(searchBreedsExpectation)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func breeds() -> AnyPublisher<[cats.Breed], Error> {

        return Just(breedsExpectation)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
