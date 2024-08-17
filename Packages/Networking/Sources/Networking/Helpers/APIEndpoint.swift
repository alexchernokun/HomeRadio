//
//  APIEndpoint.swift
//  Networking
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation

public protocol APIEndpoint {
    var url: URL { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var query: [String: String?]? { get }
    var method: HTTPMethod { get }
}

public extension APIEndpoint {
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = query?.compactMap { key, value in
            return URLQueryItem(name: key, value: value)
        }
        return urlComponents.url!
    }
}
