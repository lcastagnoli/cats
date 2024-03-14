//
//  BreedsService.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Combine
import Network
import SwiftData
import Foundation

protocol BreedsServiceProtocol {

    func searchBreed(with query: String) -> AnyPublisher<[Breed], Error>
    func breeds() -> AnyPublisher<[Breed], Error>
}

struct BreedsService {

    // MARK: Properties
    private let service: NetworkProtocol

    // MARK: Initializers
    public init(service: NetworkProtocol) {

        self.service = service
    }
}

// MARK: - BreedsServiceProtocol
extension BreedsService: BreedsServiceProtocol {
 
    func breeds() -> AnyPublisher<[Breed], Error> {
        let urlRequest = BreedsRouter.breeds.asURLRequest()
        return service.request(urlRequest)
    }
    
    func searchBreed(with query: String) -> AnyPublisher<[Breed], Error> {
        let urlRequest = BreedsRouter.search(query).asURLRequest()
        return service.request(urlRequest)
    }
}
