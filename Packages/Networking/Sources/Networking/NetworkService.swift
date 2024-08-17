//
//  NetworkService.swift
//  NetworkService
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation
import Combine
import AppLogger

public final class NetworkService {
    private let session = URLSession(configuration: .default)
    
    public func send<T: Codable>(_ request: Request) -> AnyPublisher<T, Error> {
        
        let urlRequest = request.urlRequest()
        
        AppLogger.log("Network request: \(request.apiEndpoint.method.rawValue) \(request.apiEndpoint.url)", type: .network)
        
        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse {
                    AppLogger.log("Response code \(response.statusCode)", type: .network)
                }
                return data
            }
            .mapError { error in
                AppLogger.log("Network error \(error)", type: .error)
                return error
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    public init() {}
}
