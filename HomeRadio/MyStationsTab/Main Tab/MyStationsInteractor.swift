//
//  MyStationsInteractor.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import Combine
import RadioPlayer
import DomainLayer
import Utils

final class MyStationsInteractor {
    
    private let presenter: MyStationsPresenter
    private let radioPlayer: RadioPlayer
    private var subscriptions = Set<AnyCancellable>()
    
    func getMyStations() {
        getStationsFromUserDefaults()
    }
    
    func playRadio(_ station: RadioStation) {
        guard let url = station.url else { return }
        presenter.updateCurrentStation(station)
        radioPlayer.playRadio(from: url)
    }
    
    func getMetadata() {
        metadata()
    }
    
    init(presenter: MyStationsPresenter,
         radioPlayer: RadioPlayer) {
        self.presenter = presenter
        self.radioPlayer = radioPlayer
        getMetadata()
    }
}

private extension MyStationsInteractor {
    func getStationsFromUserDefaults() {
        guard let myStations: [RadioStation] = Defaults.getMyStations(for: Defaults.myStationsKey) else {
            presenter.showEmptyState()
            return
        }
        presenter.showMyStations(myStations)
    }
    
    func metadata() {
        radioPlayer.trackTitle
            .sink { [weak self] title in
                guard let self else { return }
                self.presenter.updateMetadata(title)
            }
            .store(in: &subscriptions)
    }
}
