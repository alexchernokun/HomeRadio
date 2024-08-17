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
    func execute() -> AnyPublisher<[RadioItem], Error>
}

public struct GetCategoriesUseCaseImpl: GetCategoriesUseCase {
    
    private let tuneInRepository: TuneInRepositoryProtocol
    
    public func execute() -> AnyPublisher<[RadioItem], Error> {
        return tuneInRepository
            .getGeneralTuneInCategories()
            .map { (response: GeneralTuneInResponse) -> [RadioItem] in
                return response.body.map { RadioItemMapper.map($0) }
            }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepositoryProtocol) {
        self.tuneInRepository = tuneInRepository
    }
}
