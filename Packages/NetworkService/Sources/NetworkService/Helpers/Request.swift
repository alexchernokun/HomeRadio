//
//  CombineRequest.swift
//  RadioSwiftUI
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation

public struct Request {
    
    public let apiEndpoint: APIEndpoint
    
    public func urlRequest() -> URLRequest {
        var request = URLRequest(url: apiEndpoint.url)
        request.httpMethod = apiEndpoint.method.rawValue
        return request
    }
    
    public init(apiEndpoint: APIEndpoint) {
        self.apiEndpoint = apiEndpoint
    }
    
}
