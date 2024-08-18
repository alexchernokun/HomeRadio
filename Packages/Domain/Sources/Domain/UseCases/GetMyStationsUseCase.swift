//
//  GetMyStationsUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Combine
import Data

public protocol GetMyStationsUseCase {
    func execute() -> AnyPublisher<[RadioStationItem], Error>
}

public struct GetMyStationsUseCaseImpl: GetMyStationsUseCase {
    
    private let tuneInRepository: TuneInRepository
    
    public func execute() -> AnyPublisher<[RadioStationItem], Error> {
        return tuneInRepository
            .fetchMyStations()
            .map { MyStationsMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
