//
//  ItunesSearchRepository.swift
//  Data
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import Foundation
import Combine
import Networking

public protocol ItunesSearchRepository {
    func search(title: String) -> AnyPublisher<ItunesSearchResponse?, Error>
}

public final class ItunesSearchRepositoryImpl: ItunesSearchRepository, ObservableObject {
    
    public let networkService = NetworkService()
    
    public func search(title: String) -> AnyPublisher<ItunesSearchResponse?, Error> {
        let request = Request(apiEndpoint: ItunesAPIEndpoint.search(title))
        
        return networkService
            .send(request)
            .eraseToAnyPublisher()
    }
    
    public init() {}
}
