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
    @Published var isLoading = true
    @Published var shouldShowError = false
    @Published var title: String = ""
    @Published var radioItems: [RadioItem] = []
    
    // From interator:
    // MARK: Properties
    let query: [String: String?]
    let path: String
    private let tuneInRepository: TuneInRepositoryProtocol
    private let radioPlayer: RadioPlayer
    private var subscriptions = Set<AnyCancellable>()
    private var container = DIContainer.shared
    
    // From presenter:
    // MARK: Methods
    func showItems(_ title: String?, _ stations: [RadioItem]) {
        isLoading = false
        self.title = title ?? "Browse Station"
        radioItems = stations
    }
    
    func showErrorState() {
        isLoading = false
        shouldShowError = true
    }
    
    func clearErrorState() {
        isLoading = true
        shouldShowError = false
    }
    
    // From interactor:
    // MARK: Methods
    func fetchRadioStationItems() {
        clearErrorState()
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
    init(tuneInRepository: TuneInRepositoryProtocol,
         radioPlayer: RadioPlayer,
         path: String,
         query: [String: String?]) {
        self.tuneInRepository = tuneInRepository
        self.radioPlayer = radioPlayer
        self.path = path
        self.query = query
    }
}

// MARK: - Private methods
private extension SubCategoryViewModel {
    
    func getItems() {
        tuneInRepository.getSubCategory(path: path, query: query)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    showErrorState()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                let items = mapResponseType(from: response)
                self.showItems(response.head?.title, items)
            }
            .store(in: &subscriptions)
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
