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
import NetworkService
import DomainLayer
import Utils

final class SubCategoryViewModel: ObservableObject {
    
    // MARK: Properties
    let query: [String: String?]
    let path: String
    private(set) var tuneInRepository: TuneInRepositoryProtocol?
    private(set) var radioPlayer: RadioPlayer?
    private var subscriptions = Set<AnyCancellable>()
    @Published var isLoading = true
    @Published var shouldShowError = false
    @Published var title: String = ""
    @Published var radioItems: [RadioItem] = []
    
    // MARK: Initialization
    init(path: String,
         query: [String: String?]) {
        self.path = path
        self.query = query
    }
    
    // MARK: Methods
    func onEvent(_ event: SubCategoryScreenEvent) {
        switch event {
        case let .configure(radioPlayer, tuneInRepository):
            configure(radioPlayer: radioPlayer,
                      tuneInRepository: tuneInRepository)
        case .fetchRadioStations:
            fetchRadioStationItems()
        case let .playRadio(station):
            playRadio(station)
        case let .save(station):
            save(station)
        }
    }
}

// MARK: - Private methods
private extension SubCategoryViewModel {
    
    func configure(radioPlayer: RadioPlayer,
                   tuneInRepository: TuneInRepositoryProtocol) {
        self.radioPlayer = radioPlayer
        self.tuneInRepository = tuneInRepository
    }
    
    func fetchRadioStationItems() {
        isLoading = true
        shouldShowError = false
        getItems()
    }
    
    func getItems() {
        tuneInRepository?.getSubCategory(path: path, query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    isLoading = false
                    shouldShowError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                let items = mapResponseType(from: response)
                isLoading = false
                self.title = response.head?.title ?? "Browse Station"
                radioItems = items
            }
            .store(in: &subscriptions)
    }
    
    func playRadio(_ station: RadioItem) {
        guard let url = station.url else { return }
        radioPlayer?.playRadio(from: url)
    }
    
    func save(_ station: RadioItem) {
        guard var myStations: [RadioItem] = Defaults.get(for: Defaults.myStationsKey) else {
            Defaults.save(object: [station], for: Defaults.myStationsKey)
            return
        }
        myStations.append(station)
        Defaults.save(object: myStations, for: Defaults.myStationsKey)
    }
    
    func mapResponseType(from response: GeneralTuneInResponse) -> [RadioItem] {
        return response.body.map { RadioItem($0) }
    }
}
