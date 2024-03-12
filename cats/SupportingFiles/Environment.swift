//
//  Environment.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Foundation

enum Environment {

    static var baseUrl: URL {

        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String,
            let url = URL(string: string) else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return url
    }
}