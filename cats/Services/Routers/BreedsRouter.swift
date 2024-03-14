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

    var baseURL: URL { Environment.baseUrl }

    var method: Network.Method {

        switch self {

        case .breeds,
             .search:
            return .get
        }
    }

    var path: String {

        switch self {

        case .breeds:
            return "/breeds"
        case .search:
            return "/breeds/search"
        }
    }
    
    var headers: [String : String]? {
        
        return ["x-api-key": Environment.apiKey]
    }
    
    var queries: [String : String]? {
        
        switch self {
        case let .search(text):
            return ["q": text]
        default: return [:]
        }
    }
}

