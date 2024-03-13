//
//  BreedsRouter.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Foundation
import Network

enum BreedsRouter: URLRequestCreator {

    case breeds
    case search(String)
    case favourites
    case addfavourite
    case deletefavourite(String)

    var baseURL: URL { Environment.baseUrl }

    var method: Network.Method {

        switch self {

        case .breeds,
             .search,
             .favourites:
            return .get
        case .addfavourite:
            return .post
        case .deletefavourite:
            return .delete
        }
    }

    var path: String {

        switch self {

        case .breeds:
            return "/breeds"
        case .search:
            return "/breeds/search"
        case .addfavourite,
             .favourites:
            return "/breeds/favourites"
        case let .deletefavourite(id):
            return "/breeds/favourites/\(id)"
        }
    }
    
    var headers: [String : String]? {
        
        return ["x-api-key": "live_xXBTalO9OhXMTp9RtonV24hUE7a7ob4hJ3XEA3LIT0aQVQsZpfTJf7mKxzdf66O0"]
    }
    
    var queries: [String : String]? {
        
        switch self {
        case let .search(text):
            return ["q": text]
        default: return [:]
        }
    }
}

