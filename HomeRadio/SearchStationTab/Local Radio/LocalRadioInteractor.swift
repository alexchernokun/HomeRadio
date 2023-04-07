//
//  LocalRadioInteractor.swift
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

final class LocalRadioInteractor {
    
    // MARK: Properties
    private let presenter: LocalRadioPresenter
    private let localRadioRepository: LocalRadioRepository
    private let radioPlayer: RadioPlayer
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func fetchLocalRadioStations() {
        getLocalRadios()
    }
    
    func playRadio(from url: URL?) {
        guard let url else { return }
        radioPlayer.playRadio(from: url)
    }
    
    func saveToMyStations(_ station: RadioStation) {
        save(station)
    }
    
    // MARK: Initialization
    init(presenter: LocalRadioPresenter,
         localRadioRepository: LocalRadioRepository,
         radioPlayer: RadioPlayer) {
        self.presenter = presenter
        self.localRadioRepository = localRadioRepository
        self.radioPlayer = radioPlayer
    }
}


// MARK: Private methods
private extension LocalRadioInteractor {
    func getLocalRadios() {
        localRadioRepository.getLocalRadioStations()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    self.presenter.showErrorState()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] localStations in
                guard let self else { return }
                self.presenter.showLocalStations(localStations)
            }
            .store(in: &subscriptions)
    }
    
    func save(_ station: RadioStation) {
        guard var myStations: [RadioStation] = Defaults.getMyStations(for: Defaults.myStationsKey) else {
            Defaults.saveMyStations(object: [station], for: Defaults.myStationsKey)
            return
        }
        myStations.append(station)
        Defaults.saveMyStations(object: myStations, for: Defaults.myStationsKey)
    }
}
