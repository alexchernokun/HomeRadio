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
    func execute() -> AnyPublisher<[RadioItem], Error>
}

public struct GetMyStationsUseCaseImpl: GetMyStationsUseCase {
    
    private let tuneInRepository: TuneInRepositoryProtocol
    
    public func execute() -> AnyPublisher<[RadioItem], Error> {
        return tuneInRepository
            .getMyStations()
            .map { MyStationsMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepositoryProtocol) {
        self.tuneInRepository = tuneInRepository
    }
}
