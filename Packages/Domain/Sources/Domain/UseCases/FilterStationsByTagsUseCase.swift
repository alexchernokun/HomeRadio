//
//  FilterStationsByTagsUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation
import Data

public protocol FilterStationsByTagsUseCase {
    func execute(selectedTags: [String]) -> [RadioStationItem]?
}

public struct FilterStationsByTagsUseCaseImpl: FilterStationsByTagsUseCase {
    
    private let tuneInRepository: TuneInRepository
    
    public func execute(selectedTags: [String]) -> [RadioStationItem]? {
        guard let mappedStations = tuneInRepository
            .getCachedStations()
            .map({ MyStationsMapper.map($0) }) else { return nil }
        
        return mappedStations.filter { stationItem in
            guard let tags = stationItem.tags else { return false }
            let stationTags = Set(tags)
            let selectedTags = Set(selectedTags.map { $0.lowercased() } )
            return stationTags.contains(selectedTags)
        }
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
