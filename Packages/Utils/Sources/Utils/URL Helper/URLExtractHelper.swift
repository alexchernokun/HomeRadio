//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 09.04.2023.
//

import Foundation

public struct URLExtractHelper {
    public static func extractQueryFrom(_ url: URL) -> [String: String?] {
        var query: [String: String] = [:]
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return [:] }
        guard let queryItems = urlComponents.queryItems else { return [:] }
        
        for queryItem in queryItems {
            query[queryItem.name] = queryItem.value
        }
        
        return query
    }
    
    public static func extractPathFrom(_ url: URL) -> String {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return "" }
        let path = urlComponents.path
        return path
    }
}
