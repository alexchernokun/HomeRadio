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
    private let tuneInRepository: TuneInRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func fetchCategories() {
        presenter.clearErrorState()
        getMainCategories()
    }
    
    func navigateTo(_ category: BrowseStationsViewModel.CategoryViewModel) -> some View {
        let path = "/Browse.ashx"
        var query: [String: String?] = [:]
        
        switch category.text {
        case "Local Radio": query = ["c": "local"]
        case "Music": query = ["c": "music"]
        case "Talk": query = ["c": "talk"]
        case "Sports": query = ["c": "sports"]
        case "By Location": query = ["id": "r0"]
        case "By Language": query = ["c": "lang"]
        case "Podcasts": query = ["c": "podcast"]
        default: break
        }
        
        return SubCategoryModuleBuilder(path: path, query: query).build()
    }
    
    // MARK: Initialization
    init(presenter: BrowseStationsPresenter, tuneInRepository: TuneInRepository) {
        self.presenter = presenter
        self.tuneInRepository = tuneInRepository
    }
}

// MARK: - Private methods
private extension BrowseStationsInteractor {
    func getMainCategories() {
        tuneInRepository.getGeneralTuneInCategories()
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
