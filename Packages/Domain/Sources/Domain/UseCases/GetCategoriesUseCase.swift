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
    func execute() -> AnyPublisher<[CategoryModel], Error>
}

public struct GetCategoriesUseCaseImpl: GetCategoriesUseCase {
    
    private let tuneInRepository: TuneInRepository

    public func execute() -> AnyPublisher<[CategoryModel], Error> {
        return tuneInRepository
            .getGeneralTuneInCategories()
            .map { (response: GeneralTuneInResponse) -> [CategoryModel] in
                let stationItems = response.body.map { RadioItemMapper.map($0) }
                return stationItems.map { CategoryModel($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
