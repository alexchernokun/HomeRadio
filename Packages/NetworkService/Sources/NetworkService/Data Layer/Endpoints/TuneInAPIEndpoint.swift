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
        case subCategory(_ id: String)
        case subCategoryLocation(_ id: String)
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
        case .subCategory: return "/Browse.ashx"
        case .subCategoryLocation: return "/Browse.ashx"
        }
    }
    
    var query: [String: String?]? {
        var generalQuery = ["render": "json"]
        switch kind {
            // TODO: Check if we need local kind
        case .local:
            generalQuery["c"] = "local"
        case .subCategory(let id):
            generalQuery["c"] = id
        case .subCategoryLocation(let id):
            generalQuery["id"] = id
        default:
            break
        }
        return generalQuery
    }
    
    var method: HTTPMethod {
        return .get
    }
}
