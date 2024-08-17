//
//  MyStationsViewModel.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import Combine
import RadioPlayer
import Domain
import AppLogger

final class MyStationsViewModel: ObservableObject {
    
    // MARK: Properties
    private let getMyStationsUseCase: GetMyStationsUseCase
    private let getTrackArtworkUseCase: GetTrackArtworkUseCase
    private let radioPlayer: RadioPlayer
    private var subscriptions = Set<AnyCancellable>()
    private var cancelableSubscriptions = Set<AnyCancellable>()
    @Published var myStations: [RadioItem] = []
    @Published var currentStation: RadioItem?
    @Published var isRadioPlaying: Bool = false
    @Published var shouldShowError = false
    
    // MARK: Methods
    func onEvent(_ event: MyStationsScreenEvent) {
        switch event {
        case .onAppear, .getMyRadioStations:
            getMyStations()
        case let .playRadio(station):
            playRadio(station)
        case .onPlayButtonTap:
            toggleRadioPlayback()
        }
    }
    
    // MARK: Initialization
    init(getMyStationsUseCase: GetMyStationsUseCase,
         getTrackArtworkUseCase: GetTrackArtworkUseCase,
         radioPlayer: RadioPlayer) {
        self.getMyStationsUseCase = getMyStationsUseCase
        self.getTrackArtworkUseCase = getTrackArtworkUseCase
        self.radioPlayer = radioPlayer
        observeStreamingMetadata()
    }
}

// MARK: - Private Methods
private extension MyStationsViewModel {
    
    func getMyStations() {
        shouldShowError = false
        getMyStationsUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self else { return }
                    AppLogger.log(error, type: .error)
                    shouldShowError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] stations in
                guard let self else { return }
                myStations = stations
            }
            .store(in: &subscriptions)
    }
    
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
                fetchArtwork(for: title)
            }
            .store(in: &subscriptions)
    }
    
    func playRadio(_ station: RadioItem) {
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
    
    func fetchArtwork(for title: String) {
        cancelableSubscriptions.removeAll()
        
        getTrackArtworkUseCase
            .execute(title: title)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    // No error handling, because we already have a subtext value on TuneIn API
                    AppLogger.log(error, type: .error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] artworkUrl in
                guard let self else { return }
                currentStation?.artworkFromMetadata = artworkUrl
                NowPlayingService.addNowPlayingInfo(from: PlayingInfo(text: currentStation?.text,
                                                                      metadata: currentStation?.metadata,
                                                                      artworkFromMetadata: currentStation?.artworkFromMetadata,
                                                                      image: currentStation?.image))
            }
            .store(in: &cancelableSubscriptions)
    }
}
