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

final class BrowseMainCategoriesInteractor {
    
    // MARK: Properties
    private let container = DIContainer.shared
    private let presenter: BrowseMainCategoriesPresenter
    private let tuneInRepository: TuneInRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func fetchCategories() {
        presenter.clearErrorState()
        getMainCategories()
    }
    
    func navigateToLink(_ url: URL?) -> some View {
        guard let url else {
            return SubCategoryModuleBuilder(path: "", query: [:]).build()
        }
        
        let query = URLExtractHelper.extractQueryFrom(url)
        let path = URLExtractHelper.extractPathFrom(url)
        
        return SubCategoryModuleBuilder(path: path, query: query).build()
    }
    
    // MARK: Initialization
    init(presenter: BrowseMainCategoriesPresenter, tuneInRepository: TuneInRepository) {
        self.presenter = presenter
        self.tuneInRepository = tuneInRepository
    }
}

// MARK: - Private methods
private extension BrowseMainCategoriesInteractor {
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
