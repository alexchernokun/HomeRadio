//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation

private struct TuneInAPIConstants {
    static let scheme = "http"
    static let host = "opml.radiotime.com"
}

struct TuneInAPIEndpoint: APIEndpoint {
    
    enum Kind {
        case main
        case subCategory(_ path: String, _ query: [String: String?])
    }
    
    var kind: Kind
    
    var scheme: String {
        return TuneInAPIConstants.scheme
    }
    
    var host: String {
        return TuneInAPIConstants.host
    }
    
    var path: String {
        switch kind {
        case .main: return ""
        case let .subCategory(path, _):
            return path
        }
    }
    
    var query: [String: String?]? {
        var generalQuery: [String: String?] = ["": ""]
        switch kind {
        case let .subCategory(_, query):
            generalQuery = query
        default:
            break
        }
        generalQuery["render"] = "json"
        return generalQuery
    }
    
    var method: HTTPMethod {
        return .get
    }
}
