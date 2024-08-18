//
//  ItunesAPIEndpoint.swift
//  Data
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation
import Networking

private struct ItunesAPIConstants {
    static let scheme = "https"
    static let host = "itunes.apple.com"
}

enum ItunesAPIEndpoint: APIEndpoint {
    
    case search(_ title: String)
    
    var scheme: String {
        return ItunesAPIConstants.scheme
    }
    
    var host: String {
        return ItunesAPIConstants.host
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var query: [String : String?]? {
        switch self {
        case .search(let title):
            return ["term": title,
                    "entity": "song"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
}
