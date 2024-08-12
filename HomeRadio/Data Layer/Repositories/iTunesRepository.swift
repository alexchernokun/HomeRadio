//
//  File.swift
//  
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation
import Combine
import DomainLayer
import NetworkService

public protocol ItunesSearchRepositoryProtocol {
    func search(title: String) -> AnyPublisher<URL?, Error>
}

public final class ItunesSearchRepository: ItunesSearchRepositoryProtocol {
    
    public let networkService = NetworkService()
    
    // MARK: Requests
    public func search(title: String) -> AnyPublisher<URL?, Error> {
        let request = Request(apiEndpoint: ItunesAPIEndpoint.search(title))
        
        return networkService
            .send(request)
            .map { (response: ItunesSearchResponse) -> URL? in
                return response.results.first?.artworkUrl
            }
            .eraseToAnyPublisher()
    }
    
    public init() {}
}
