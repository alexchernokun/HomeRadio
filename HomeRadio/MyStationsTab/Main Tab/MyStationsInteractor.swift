//
//  MyStationsInteractor.swift
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

final class MyStationsInteractor {
    
    // MARK: Properties
    private let presenter: MyStationsPresenter
    private let radioPlayer: RadioPlayer
    private let iTunesRepository: ItunesSearchRepository
    private var subscriptions = Set<AnyCancellable>()
    private var cancelableSubscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func getMyStations() {
        getStationsFromUserDefaults()
    }
    
    func playRadio(_ station: RadioStation) {
        guard let url = station.url else { return }
        presenter.updateCurrentStation(station)
        presenter.makeStopButton()
        radioPlayer.playRadio(from: url)
    }
    
    func toggleRadioPlayback() {
        guard let url = presenter.currentStation?.url else { return }
        presenter.isRadioPlaying ? radioPlayer.pauseRadio() : radioPlayer.playRadio(from: url)
        presenter.toggleIsRadioPlaying()
    }
    
    func getMetadata() {
        subscribeToMetadataPublisher()
    }
    
    func updateNowPlayingInfoCenter() {
        NowPlayingService.addNowPlayingInfo(from: presenter.currentStation)
    }
    
    // MARK: Initialization
    init(presenter: MyStationsPresenter,
         radioPlayer: RadioPlayer,
         iTunesRepository: ItunesSearchRepository) {
        self.presenter = presenter
        self.radioPlayer = radioPlayer
        self.iTunesRepository = iTunesRepository
        getMetadata()
    }
}

// MARK: - Private Methods
private extension MyStationsInteractor {
    func getStationsFromUserDefaults() {
        guard let myStations: [RadioStation] = Defaults.getMyStations(for: Defaults.myStationsKey) else {
            presenter.showEmptyState()
            return
        }
        presenter.showMyStations(myStations)
    }
    
    func subscribeToMetadataPublisher() {
        radioPlayer.trackTitle
            .sink { [weak self] title in
                guard let self else { return }
                self.updateNowPlayingInfoCenter()
                self.presenter.updateMetadata(title)
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
                self.presenter.updateArtwork(artworkUrl)
                self.updateNowPlayingInfoCenter()
            }
            .store(in: &cancelableSubscriptions)
    }
}
