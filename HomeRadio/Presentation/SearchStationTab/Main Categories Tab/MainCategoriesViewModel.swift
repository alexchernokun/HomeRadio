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
    @Published var localCategory: CategoryViewModel?
    @Published var musicCategory: CategoryViewModel?
    @Published var talkCategory: CategoryViewModel?
    @Published var sportsCategory: CategoryViewModel?
    @Published var locationCategory: CategoryViewModel?
    @Published var languageCategory: CategoryViewModel?
    @Published var podcastsCategory: CategoryViewModel?
    
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

extension MainCategoriesViewModel {
    
    struct CategoryViewModel {
        var type: RadioItemType
        var key: String?
        var text: String
        var url: URL?
        var imageName: String
        var color: String

        init(_ category: RadioStationItem) {
            self.type = category.type
            self.text = category.text
            self.url = category.url
            self.key = category.key

            switch key {
            case "local":
                self.imageName = "location.circle"
                self.color = Colors.categoryRed
            case "music":
                self.imageName = "music.note"
                self.color = Colors.categoryBlue
            case "talk":
                self.imageName = "waveform.and.mic"
                self.color = Colors.bgSecondary
            case "sports":
                self.imageName = "sportscourt"
                self.color = Colors.categoryOrange
            case "location":
                self.imageName = "mappin.and.ellipse"
                self.color = Colors.categoryGreen
            case "language":
                self.imageName = "globe"
                self.color = Colors.categoryYellow
            case "podcast":
                self.imageName = "mic.fill"
                self.color = Colors.categoryBrown
            default:
                self.imageName = "questionmark"
                self.color = "bgSecondary"
            }
        }
    }
}

// MARK: - Private methods
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
                showCategories(categories)
            }
            .store(in: &subscriptions)
    }
    
    // Most likely move to domain
    func showCategories(_ categories: [RadioStationItem]) {
        for category in categories {
            switch category.key {
            case "local":
                localCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "music":
                musicCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "talk":
                talkCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "sports":
                sportsCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "location":
                locationCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "language":
                languageCategory = MainCategoriesViewModel.CategoryViewModel(category)
            case "podcast":
                podcastsCategory = MainCategoriesViewModel.CategoryViewModel(category)
            default: break
            }
        }

        isLoading = false
    }
}
