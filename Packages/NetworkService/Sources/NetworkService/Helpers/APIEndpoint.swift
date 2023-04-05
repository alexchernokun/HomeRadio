//
//  CombineAPIEndpoint.swift
//  RadioSwiftUI
//
//  Created by Oleksandr Chornokun on 1/19/22.
//

import Foundation

public protocol APIEndpoint {
    var url: URL { get }
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var version: String? { get }
    var query: [String: String?]? { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var contentType: HTTPContentType { get }
    var data: Data? { get }
}

public extension APIEndpoint {
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.port = port
        urlComponents.queryItems = query?.compactMap { key, value in
            return URLQueryItem(name: key, value: value)
        }
        return urlComponents.url!
    }
}
