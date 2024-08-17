//
//  TuneInAPIEndpoint.swift
//  Data
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import Foundation
import Networking

private struct TuneInAPIConstants {
    static let scheme = "http"
    static let host = "opml.radiotime.com"
}

private struct TuneInMyStationsConstants {
    static let scheme = "https"
    static let host = "s3-us-west-1.amazonaws.com"
}

enum TuneInAPIEndpoint: APIEndpoint {
    
    case main
    case myStations
    case subCategory(_ path: String, _ query: [String: String?])
    
    var scheme: String {
        switch self {
        case .main, .subCategory:
            return TuneInAPIConstants.scheme
        case .myStations:
            return TuneInMyStationsConstants.scheme
        }
    }
    
    var host: String {
        switch self {
        case .main, .subCategory:
            return TuneInAPIConstants.host
        case .myStations:
            return TuneInMyStationsConstants.host
        }
    }
    
    var path: String {
        switch self {
        case .main: return ""
        case .myStations: return "/cdn-web.tunein.com/stations.json"
        case let .subCategory(path, _): return path
        }
    }
    
    var query: [String: String?]? {
        switch self {
        case .main:
            var generalQuery: [String: String?] = ["": ""]
            generalQuery["render"] = "json"
            return generalQuery
        case let .subCategory(_, query):
            var generalQuery: [String: String?] = ["": ""]
            generalQuery = query
            generalQuery["render"] = "json"
            return generalQuery
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
