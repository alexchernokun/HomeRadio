//
//  GetSubcategoriesUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Combine
import Data

public protocol GetSubcategoriesUseCase {
    func execute(path: String, query: [String: String?]) -> AnyPublisher<SubCategoriesModel, Error>
}

public struct GetSubcateriesUseCaseImpl: GetSubcategoriesUseCase {
    
    private let tuneInRepository: TuneInRepositoryProtocol
    
    public func execute(path: String, query: [String: String?]) -> AnyPublisher<SubCategoriesModel, Error> {
        return tuneInRepository
            .getSubCategory(path: path, query: query)
            .map { SubCategoriesModel(title: $0.head?.title ?? "Browse Stations",
                                      subcategories: $0.body.map { RadioItemMapper.map($0) })
            }
            .eraseToAnyPublisher()
    }
    
    public init(tuneInRepository: TuneInRepositoryProtocol) {
        self.tuneInRepository = tuneInRepository
    }
}

public struct SubCategoriesModel {
    public let title: String
    public let subcategories: [RadioItem]
}
