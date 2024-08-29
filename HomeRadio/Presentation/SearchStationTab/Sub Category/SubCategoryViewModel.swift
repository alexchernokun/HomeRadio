//
//  SubCategoryViewModel.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import Foundation
import SwiftUI
import Combine
import RadioPlayer
import Domain
import AppLogger

final class SubCategoryViewModel: ObservableObject {
    
    // MARK: Properties
    private let getSubcategoriesUseCase: GetSubcategoriesUseCase
    private let radioPlayer: RadioPlayer
    private let query: [String: String?]
    private let path: String
    private var subscriptions = Set<AnyCancellable>()
    @Published var currentStation: RadioStationItem?
    @Published var isRadioPlaying: Bool = false
    @Published var isLoading = true
    @Published var shouldShowError = false
    @Published var title: String = ""
    @Published var subcategoryItems: [RadioStationItem] = []
    
    // MARK: Initialization
    init(radioPlayer: RadioPlayer,
         getSubcategoriesUseCase: GetSubcategoriesUseCase,
         path: String = "",
         query: [String: String?] = [:]) {
        self.radioPlayer = radioPlayer
        self.getSubcategoriesUseCase = getSubcategoriesUseCase
        self.path = path
        self.query = query
        observeStreamingMetadata()
    }
    
    // MARK: Methods
    func onEvent(_ event: SubCategoryScreenEvent) {
        switch event {
        case .fetchRadioStations:
            fetchRadioStationItems()
        case let .playRadio(station):
            playRadio(station)
        }
    }
}

// MARK: Private methods
private extension SubCategoryViewModel {
    
    func observeStreamingMetadata() {
        radioPlayer
            .trackTitle
            .sink { [weak self] title in
                guard let self else { return }
                NowPlayingService.addNowPlayingInfo(from: PlayingInfo(text: currentStation?.text,
                                                                      metadata: currentStation?.metadata,
                                                                      artworkFromMetadata: currentStation?.artworkFromMetadata,
                                                                      image: currentStation?.image))
                currentStation?.metadata = title
            }
            .store(in: &subscriptions)
    }
    
    func playRadio(_ station: RadioStationItem) {
        guard let url = station.url else { return }
        currentStation = station
        isRadioPlaying = true
        radioPlayer.playRadio(from: url)
    }
    
    func toggleRadioPlayback() {
        guard let url = currentStation?.url else { return }
        isRadioPlaying ? radioPlayer.pauseRadio() : radioPlayer.playRadio(from: url)
        isRadioPlaying.toggle()
    }

    func fetchRadioStationItems() {
        isLoading = true
        shouldShowError = false
        getItems()
    }
    
    func getItems() {
        getSubcategoriesUseCase
            .execute(path: path, query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    AppLogger.log(error, type: .error)
                    isLoading = false
                    shouldShowError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] subcategoriesResponse in
                guard let self else { return }
                isLoading = false
                title = subcategoriesResponse.title
                subcategoryItems = subcategoriesResponse.subcategories
            }
            .store(in: &subscriptions)
    }
}
