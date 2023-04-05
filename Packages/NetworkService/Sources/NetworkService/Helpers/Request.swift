//
//  CombineRequest.swift
//  RadioSwiftUI
//
//  Created by Oleksandr Chornokun on 1/19/22.
//

import Foundation

public struct Request {
    
    public let apiEndpoint: APIEndpoint
    
    public func urlRequest() -> URLRequest {
        var request = URLRequest(url: apiEndpoint.url)
        request.httpMethod = apiEndpoint.method.rawValue
        for (key, value) in apiEndpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let data = apiEndpoint.data {
            request.httpBody = data
        }
        return request
    }
    
    public init(apiEndpoint: APIEndpoint) {
        self.apiEndpoint = apiEndpoint
    }
    
}
