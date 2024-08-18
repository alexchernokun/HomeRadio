//
//  DependencyContainer.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 17.08.2024.
//

import Foundation
import Domain
import Data
import Persistence
import RadioPlayer

final class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private let userDefaultsManager = UserDefaultsManager()
    private(set) var tuneInRepository: TuneInRepository
    private(set) var itunesRepository: ItunesSearchRepository
    private(set) var getMyStationsUseCase: GetMyStationsUseCase
    private(set) var getRadioStationTagsUseCase: GetRadioStationTagsUseCase
    private(set) var filterStationsByTagsUseCase: FilterStationsByTagsUseCase
    private(set) var getTrackArtworkUseCase: GetTrackArtworkUseCase
    private(set) var getCategoriesUseCase: GetCategoriesUseCase
    private(set) var getSubcategoriesUseCase: GetSubcategoriesUseCase
    private(set) var radioPlayer: RadioPlayer
    
    private init() {
        self.tuneInRepository = TuneInRepositoryImpl(userDefaultsManager: userDefaultsManager)
        self.itunesRepository = ItunesSearchRepositoryImpl()
        self.getMyStationsUseCase = GetMyStationsUseCaseImpl(tuneInRepository: tuneInRepository)
        self.getRadioStationTagsUseCase = GetRadioStationTagsUseCaseImpl(tuneInRepository: tuneInRepository)
        self.filterStationsByTagsUseCase = FilterStationsByTagsUseCaseImpl(tuneInRepository: tuneInRepository)
        self.getTrackArtworkUseCase = GetTrackArtworkUseCaseImpl(itunesRepository: itunesRepository)
        self.getCategoriesUseCase = GetCategoriesUseCaseImpl(tuneInRepository: tuneInRepository)
        self.getSubcategoriesUseCase = GetSubcateriesUseCaseImpl(tuneInRepository: tuneInRepository)
        self.radioPlayer = RadioPlayer()
    }
}
