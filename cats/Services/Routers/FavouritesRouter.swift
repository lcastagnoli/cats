//
//  FavouritesRouter.swift
//  cats
//
//  Created by Laryssa Castagnoli on 13/03/24.
//

import Foundation
import Network

enum FavouritesRouter: URLRequestCreator {

    case favourites
    case addfavourite
    case deletefavourite(String)

    var baseURL: URL { Environment.baseUrl }

    var method: Network.Method {

        switch self {

        case .favourites:
            return .get
        case .addfavourite:
            return .post
        case .deletefavourite:
            return .delete
        }
    }

    var path: String {

        switch self {

        case .addfavourite,
             .favourites:
            return "/favourites"
        case let .deletefavourite(id):
            return "/favourites/\(id)"
        }
    }
    
    var headers: [String : String]? {
        
        return ["x-api-key": Environment.apiKey]
    }
}

