//
//  URLRequestCreator.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Foundation

public protocol URLRequestCreator {

    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var queries: [String: String]? { get }
}

extension URLRequestCreator {

    public var queries: [String: String]? { [:] }
    public var parameters: [String: Any]? { [:] }
    public var headers: [String: String]? { [:] }

    public func asURLRequest() -> URLRequest {

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        switch (method, queries) {

        case (.get, _):
            guard let queries else { return request }
            request.url = request.url?.appending(queries: queries)

        case (.post, let queries),
             (.delete, let queries):
            request = encode(request: &request, with: queries, and: parameters)
        }
        return request
    }

    private func encode(request: inout URLRequest,
                        with queries: [String: String]?,
                        and body: [String: Any]?) -> URLRequest {

        if let queries, !queries.isEmpty {
            request.url = request.url?.appending(queries: queries)
        }
        if let httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted) {

            request.httpBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }

        return request
    }
}
