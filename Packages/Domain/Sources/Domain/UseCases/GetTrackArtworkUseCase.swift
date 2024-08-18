//
//  GetTrackArtworkUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Combine
import Data

public protocol GetTrackArtworkUseCase {
    func execute(title: String) -> AnyPublisher<URL?, Error>
}

public struct GetTrackArtworkUseCaseImpl: GetTrackArtworkUseCase {
    
    private let itunesRepository: ItunesSearchRepository
    
    public func execute(title: String) -> AnyPublisher<URL?, Error> {
        return itunesRepository
            .search(title: title)
            .map { $0?.results.first?.artworkUrl }
            .eraseToAnyPublisher()
    }
    
    public init(itunesRepository: ItunesSearchRepository) {
        self.itunesRepository = itunesRepository
    }
}
