//
//  SubCategoryInteractor.swift
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

final class SubCategoryInteractor {
    
    // MARK: Properties
    let query: [String: String?]
    let path: String
    private let presenter: SubCategoryPresenter
    private let tuneInRepository: TuneInRepository
    private let radioPlayer: RadioPlayer
    private var subscriptions = Set<AnyCancellable>()
    private var container = DIContainer.shared
    
    // MARK: Methods
    func fetchRadioStationItems() {
        presenter.clearErrorState()
        getItems()
    }
    
    func navigateToLink(_ item: RadioItem) -> some View {
        guard let url = item.url else {
            return SubCategoryModuleBuilder(path: path, query: query).build()
        }
        
        let query = URLExtractHelper.extractQueryFrom(url)
        let path = URLExtractHelper.extractPathFrom(url)
        return SubCategoryModuleBuilder(path: path, query: query).build()
    }
    
    func playRadio(_ station: RadioItem) {
        guard let url = station.url else { return }
        radioPlayer.playRadio(from: url)
    }
    
    func saveToMyStations(_ station: RadioItem) {
        save(station)
    }
    
    // MARK: Initialization
    init(presenter: SubCategoryPresenter,
         tuneInRepository: TuneInRepository,
         radioPlayer: RadioPlayer,
         path: String,
         query: [String: String?]) {
        self.presenter = presenter
        self.tuneInRepository = tuneInRepository
        self.radioPlayer = radioPlayer
        self.path = path
        self.query = query
    }
    
}

// MARK: - Private methods
private extension SubCategoryInteractor {
    func getItems() {
        tuneInRepository.getSubCategory(path: path, query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    presenter.showErrorState()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                let items = mapResponseType(from: response)
                self.presenter.showItems(response.head?.title, items)
            }
            .store(in: &subscriptions)
    }
    
    func save(_ station: RadioItem) {
        guard var myStations: [RadioItem] = Defaults.getMyStations(for: Defaults.myStationsKey) else {
            Defaults.saveMyStations(object: [station], for: Defaults.myStationsKey)
            return
        }
        myStations.append(station)
        Defaults.saveMyStations(object: myStations, for: Defaults.myStationsKey)
    }
    
    func mapResponseType(from response: GeneralTuneInResponse) -> [RadioItem] {
        return response.body.map { RadioItem($0) }
    }
    
}
