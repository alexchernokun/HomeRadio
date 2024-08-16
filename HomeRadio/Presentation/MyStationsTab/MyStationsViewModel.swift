//
//  MyStationsViewModel.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import Combine
import RadioPlayer
import NetworkService
import DomainLayer
import Utils

final class MyStationsViewModel: ObservableObject {
    
    // MARK: Properties
    private let radioPlayer: RadioPlayer
    private let iTunesRepository: ItunesSearchRepositoryProtocol
    private var subscriptions = Set<AnyCancellable>()
    private var cancelableSubscriptions = Set<AnyCancellable>()
    @Published var myStations: [RadioItem] = []
    @Published var currentStation: RadioItem?
    @Published var isRadioPlaying: Bool = false
    
    // MARK: Methods
    func onEvent(_ event: MyStationsScreenEvent) {
        switch event {
        case .onAppear, .getRadioStations:
            getMyStations()
        case let .playRadio(station):
            playRadio(station)
        case .onPlayButtonTap:
            toggleRadioPlayback()
        }
    }
    
    // MARK: Initialization
    init(radioPlayer: RadioPlayer,
         iTunesRepository: ItunesSearchRepositoryProtocol) {
        self.radioPlayer = radioPlayer
        self.iTunesRepository = iTunesRepository
        observeStreamingMetadata()
    }
}

// MARK: - Private Methods
private extension MyStationsViewModel {
    
    func getMyStations() {
        guard let stations: [RadioItem] = Defaults.get(for: Defaults.myStationsKey) else { return }
        myStations = stations
    }
    
    func observeStreamingMetadata() {
        radioPlayer.trackTitle
            .sink { [weak self] title in
                guard let self else { return }
                NowPlayingService.addNowPlayingInfo(from: currentStation)
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
        
        iTunesRepository.search(title: title)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    // No error handling, because we already have a subtext value on TuneIn API
                    Logger.logError(message: error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] artworkUrl in
                guard let self else { return }
                currentStation?.artworkFromMetadata = artworkUrl
                NowPlayingService.addNowPlayingInfo(from: currentStation)
            }
            .store(in: &cancelableSubscriptions)
    }
}
