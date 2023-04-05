//
//  NetworkService.swift
//  RadioSwiftUI
//
//  Created by Oleksandr Chornokun on 10/3/21.
//

import Foundation
import Combine

public final class NetworkService {
    private let session = URLSession(configuration: .default)
    
    public func send<T: Codable>(_ request: Request) -> AnyPublisher<T, Error> {
        
        let urlRequest = request.urlRequest()
        
        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                return data
            }
            .mapError { error in
                return error
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
    
    public init() {}
}
