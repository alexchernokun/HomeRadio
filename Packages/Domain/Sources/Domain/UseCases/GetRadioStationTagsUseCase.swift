//
//  GetRadioStationTagsUseCase.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation
import Data

public protocol GetRadioStationTagsUseCase {
    func execute() -> [RadioStationTag]
}

public struct GetRadioStationTagsUseCaseImpl: GetRadioStationTagsUseCase {
    
    private let tuneInRepository: TuneInRepository
    
    public func execute() -> [RadioStationTag] {
        return tuneInRepository
            .getRadioStationTags()
            .map { RadioStationTag(name: $0.capitalized, isToggled: false) }
            .sorted { $0.name < $1.name }
    }
    
    public init(tuneInRepository: TuneInRepository) {
        self.tuneInRepository = tuneInRepository
    }
}
