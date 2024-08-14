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
    
    // From presenter:
    // MARK: Properties
    @Published var myStations: [RadioItem] = []
    @Published var shouldShowEmptyState = false
    @Published var currentStation: RadioItem?
    @Published var isRadioPlaying: Bool = false
    
    // From interactor:
    private let radioPlayer: RadioPlayer
    private let iTunesRepository: ItunesSearchRepositoryProtocol
    private var subscriptions = Set<AnyCancellable>()
    private var cancelableSubscriptions = Set<AnyCancellable>()
    
    // From presenter:
    // MARK: Methods
    func showEmptyState() {
        shouldShowEmptyState = true
    }
    
    func showMyStations(_ stations: [RadioItem]) {
        shouldShowEmptyState = false
        myStations = stations
    }
    
    func updateCurrentStation(_ station: RadioItem) {
        currentStation = station
    }
    
    func toggleIsRadioPlaying() {
        isRadioPlaying.toggle()
        isRadioPlaying ? makeStopButton() : makePlayButton()
    }
    
    func makePlayButton() {
        isRadioPlaying = false
    }
    
    func makeStopButton() {
        isRadioPlaying = true
    }
    
    func updateMetadata(_ title: String) {
        currentStation?.metadata = title
    }
    
    func updateArtwork(_ url: URL?) {
        currentStation?.artworkFromMetadata = url
    }
    
    // From Interactor:
    // MARK: Methods
    func getMyStations() {
        getStationsFromUserDefaults()
    }
    
    func playRadio(_ station: RadioItem) {
        guard let url = station.url else { return }
        updateCurrentStation(station)
        makeStopButton()
        radioPlayer.playRadio(from: url)
    }
    
    func toggleRadioPlayback() {
        guard let url = currentStation?.url else { return }
        isRadioPlaying ? radioPlayer.pauseRadio() : radioPlayer.playRadio(from: url)
        toggleIsRadioPlaying()
    }
    
    func getMetadata() {
        subscribeToMetadataPublisher()
    }
    
    func updateNowPlayingInfoCenter() {
        NowPlayingService.addNowPlayingInfo(from: currentStation)
    }
    
    // MARK: Initialization
    init(radioPlayer: RadioPlayer,
         iTunesRepository: ItunesSearchRepositoryProtocol) {
        self.radioPlayer = radioPlayer
        self.iTunesRepository = iTunesRepository
        getMetadata()
    }
}

// MARK: - Private Methods
private extension MyStationsViewModel {
    func getStationsFromUserDefaults() {
        guard let myStations: [RadioItem] = Defaults.get(for: Defaults.myStationsKey) else {
            showEmptyState()
            return
        }
        showMyStations(myStations)
    }
    
    func subscribeToMetadataPublisher() {
        radioPlayer.trackTitle
            .sink { [weak self] title in
                guard let self else { return }
                self.updateNowPlayingInfoCenter()
                self.updateMetadata(title)
                self.fetchArtwork(for: title)
            }
            .store(in: &subscriptions)
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
                self.updateArtwork(artworkUrl)
                self.updateNowPlayingInfoCenter()
            }
            .store(in: &cancelableSubscriptions)
    }
}
