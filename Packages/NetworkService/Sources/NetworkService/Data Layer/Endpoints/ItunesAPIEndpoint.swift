//
//  ItunesAPI.swift
//  RadioSwiftUI
//
//  Created by Oleksandr Chornokun on 1/19/22.
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
    
    var port: Int? {
        return nil
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
    
    var contentType: HTTPContentType {
        switch kind {
        case .search:
            return .none
        }
    }
    
    var headers: [String : String] {
        var headers = [String: String]()
        
        headers["Content-Type"] = contentType.rawValue
        
        return headers
    }
    
    var method: HTTPMethod {
        switch kind {
        case .search:
            return .get
        }
    }
    
    var data: Data? {
        switch kind {
        default: return nil
        }
    }
    
    var version: String? {
        return nil
    }
    
}
