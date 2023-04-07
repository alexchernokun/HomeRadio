//
//  BrowseStationsInteractor.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import NetworkService
import Combine
import Utils
import SwiftUI

final class BrowseStationsInteractor {
    
    // MARK: Properties
    private let container = DIContainer.shared
    private let presenter: BrowseStationsPresenter
    private let tuneInRepository: MainTuneInRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func fetchCategories() {
        presenter.clearErrorState()
        getMainCategories()
    }
    
    func navigateToLocalStations() -> some View {
        return container.resolve(type: LocalRadioModuleBuilder.self).build()
    }
    
    func navigateToMusic() {
        
    }
    
    func navigateToTalk() {
        
    }
    
    func navigateToSports() {
        
    }
    
    func navigateToByLocation() {
        
    }
    
    func navigateToByLanguage() {
        
    }
    
    func navigateToPodcasts() {
        
    }
    
    // MARK: Initialization
    init(presenter: BrowseStationsPresenter, tuneInRepository: MainTuneInRepository) {
        self.presenter = presenter
        self.tuneInRepository = tuneInRepository
    }
}

// MARK: - Private methods
private extension BrowseStationsInteractor {
    func getMainCategories() {
        tuneInRepository.getMainTuneInCategories()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    self.presenter.showErrorState()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                self.presenter.showCategories(categories)
            }
            .store(in: &subscriptions)
    }
}
