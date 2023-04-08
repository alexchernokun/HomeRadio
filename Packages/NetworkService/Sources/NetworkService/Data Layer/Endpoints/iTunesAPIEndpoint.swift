//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation

private struct ItunesAPIConstants {
    static let scheme = "https"
    static let host = "itunes.apple.com"
}

struct ItunesAPIEndpoint: APIEndpoint {
    
    enum Kind {
        case search(_ title: String)
    }
    
    var kind: Kind
    
    var scheme: String {
        return ItunesAPIConstants.scheme
    }
    
    var host: String {
        return ItunesAPIConstants.host
    }
    
    var path: String {
        switch kind {
        case .search:
            return "/search"
        }
    }
    
    var query: [String : String?]? {
        switch kind {
        case .search(let title):
            return ["term": title,
                    "entity": "song"]
        }
    }
    
    var method: HTTPMethod {
        switch kind {
        case .search:
            return .get
        }
    }
    
}
