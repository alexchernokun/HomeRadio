//
//  BrowseMainCategoriesViewModel.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import Combine
import SwiftUI
import Domain
import AppLogger

final class MainCategoriesViewModel: ObservableObject {
    
    // MARK: Properties
    private let getCategoriesUseCase: GetCategoriesUseCase
    private var subscriptions = Set<AnyCancellable>()
    @Published var isLoading = true
    @Published var shouldShowError = false
    @Published var localCategory: CategoryModel?
    @Published var globalCategories: [CategoryModel] = []
    
    // MARK: Initialization
    init(getCategoriesUseCase: GetCategoriesUseCase) {
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    // MARK: Methods
    func onEvent(_ event: MainCategoriesScreenEvent) {
        switch event {
        case .fetchCategories:
            fetchCategories()
        }
    }
}

// MARK: Private methods
private extension MainCategoriesViewModel {
    
    func fetchCategories() {
        isLoading = true
        shouldShowError = false
        getMainCategories()
    }
    
    func getMainCategories() {
        getCategoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    AppLogger.log(error, type: .error)
                    isLoading = false
                    shouldShowError = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                localCategory = categories.filter { $0.key == .local }.first
                globalCategories = categories
                isLoading = false
            }
            .store(in: &subscriptions)
    }
}
