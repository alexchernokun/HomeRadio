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
        case local
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
        case .local: return "/Browse.ashx"
        }
    }
    
    var query: [String: String?]? {
        var generalQuery = ["render": "json"]
        switch kind {
        case .local: generalQuery["c"] = "local"
        default:
            break
        }
        return generalQuery
    }
    
    var method: HTTPMethod {
        return .get
    }
}
