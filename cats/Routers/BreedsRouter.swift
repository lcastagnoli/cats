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
    var baseURL: URL { Environment.baseUrl }

    var method: Network.Method {

        switch self {

        case .breeds:
            return .get
        }
    }

    var path: String {

        switch self {

        case .breeds:
            return "/breeds"
        }
    }
}

