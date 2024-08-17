//
//  DependencyContainer.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Domain
import Data
import RadioPlayer

final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private(set) var tuneInRepository: TuneInRepositoryProtocol
    private(set) var itunesRepository: ItunesSearchRepositoryProtocol
    private(set) var getTrackArtworkUseCase: GetTrackArtworkUseCase
    private(set) var getCategoriesUseCase: GetCategoriesUseCase
    private(set) var getSubcategoriesUseCase: GetSubcategoriesUseCase
    private(set) var radioPlayer: RadioPlayer
    
    private init() {
        self.tuneInRepository = TuneInRepository()
        self.itunesRepository = ItunesSearchRepository()
        self.getTrackArtworkUseCase = GetTrackArtworkUseCaseImpl(itunesRepository: itunesRepository)
        self.getCategoriesUseCase = GetCategoriesUseCaseImpl(tuneInRepository: tuneInRepository)
        self.getSubcategoriesUseCase = GetSubcateriesUseCaseImpl(tuneInRepository: tuneInRepository)
        self.radioPlayer = RadioPlayer()
    }
}
