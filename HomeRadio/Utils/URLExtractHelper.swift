//
//  URLExtractHelper.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation

struct URLExtractHelper {
    static func extractQueryFrom(_ url: URL) -> [String: String?] {
        var query: [String: String] = [:]
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return [:] }
        guard let queryItems = urlComponents.queryItems else { return [:] }
        
        for queryItem in queryItems {
            query[queryItem.name] = queryItem.value
        }
        
        return query
    }
    
    static func extractPathFrom(_ url: URL) -> String {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return "" }
        let path = urlComponents.path
        return path
    }
}
