//
//  ItunesSearchNetworkService.swift
//  Radio
//
//  Created by Oleksandr Chornokun on 4/8/21.
//

import Combine
import DomainLayer

public final class ItunesSearchRepository {
    
    public let networkService = NetworkService()
    
    // MARK: Requests
    public func search(title: String) -> AnyPublisher<Track, Error> {
        let request = Request(apiEndpoint: ItunesAPIEndpoint(kind: .search(title)))
        
        return networkService
            .send(request)
            .map { (response: ItunesSearchResponse) -> Track in
                return Track(from: response)
            }
            .eraseToAnyPublisher()
    }
    
    public init() {}
}

extension Track {
    init(from response: ItunesSearchResponse) {
        self.init(title: response.results.first?.trackName,
                  artist: response.results.first?.artistName)
    }
}
