//
//  SortStationsByRatingUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation
import Data

public protocol SortStationsByRatingUseCase {
    func execute(sortingType: SortingType) -> [RadioStationItem]?
}

public struct SortStationsByRatingUseCaseImpl: SortStationsByRatingUseCase {
    
    private let tuneInRepository: TuneInRepository
    
    public func execute(sortingType: SortingType) -> [RadioStationItem]? {
        guard let mappedStations = tuneInRepository
            .getCachedStations()
            .map({ MyStationsMapper.map($0) }) else { return nil }
        
        switch sortingType {
        case .asc:
            return mappedStations.sorted { $0.popularity ?? 0.0 < $1.popularity ?? 0.0 }
        case .desc:
            return mappedStations.sorted { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
        case .none:
            return mappedStations
        }
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
