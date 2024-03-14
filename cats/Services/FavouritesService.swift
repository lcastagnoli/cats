//
//  FavouritesService.swift
//  cats
//
//  Created by Laryssa Castagnoli on 13/03/24.
//

import Combine
import Network

protocol FavouritesServiceProtocol {

    func favourites() -> AnyPublisher<[Favourite], Error>
}

struct FavouritesService {

    // MARK: Properties
    private let service: NetworkProtocol

    // MARK: Initializers
    public init(service: NetworkProtocol) {

        self.service = service
    }
}

// MARK: - FavouritesServiceProtocol
extension FavouritesService: FavouritesServiceProtocol {

    func favourites() -> AnyPublisher<[Favourite], Error> {
        let urlRequest = FavouritesRouter.favourites.asURLRequest()
        return service.request(urlRequest)
    }
}
