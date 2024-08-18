//
//  GetCategoriesUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Combine
import Data

public protocol GetCategoriesUseCase {
    func execute() -> AnyPublisher<[RadioStationItem], Error>
}

public struct GetCategoriesUseCaseImpl: GetCategoriesUseCase {
    
    private let tuneInRepository: TuneInRepository
    
    public func execute() -> AnyPublisher<[RadioStationItem], Error> {
        return tuneInRepository
            .getGeneralTuneInCategories()
            .map { (response: GeneralTuneInResponse) -> [RadioStationItem] in
                return response.body.map { RadioItemMapper.map($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
