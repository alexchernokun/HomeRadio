//
//  TuneInAPIEndpoint.swift
//  
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation
import NetworkService

private struct TuneInAPIConstants {
    static let scheme = "http"
    static let host = "opml.radiotime.com"
}

enum TuneInAPIEndpoint: APIEndpoint {
    
    case main
    case subCategory(_ path: String, _ query: [String: String?])
    
    var scheme: String {
        return TuneInAPIConstants.scheme
    }
    
    var host: String {
        return TuneInAPIConstants.host
    }
    
    var path: String {
        switch self {
        case .main: return ""
        case let .subCategory(path, _): return path
        }
    }
    
    var query: [String: String?]? {
        var generalQuery: [String: String?] = ["": ""]
        
        switch self {
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
