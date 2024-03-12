//
//  BreedsService.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Combine
import Network

protocol BreedsServiceProtocol {

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
}
