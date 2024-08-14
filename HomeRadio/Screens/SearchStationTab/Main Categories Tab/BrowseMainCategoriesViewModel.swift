//
//  BrowseMainCategoriesViewModel.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import NetworkService
import Combine
import Utils
import SwiftUI
import DomainLayer

final class BrowseMainCategoriesViewModel: ObservableObject {
    
    // MARK: Properties
    @Published var isLoading = true
    @Published var shouldShowError = false
    @Published var localCategory: CategoryViewModel?
    @Published var musicCategory: CategoryViewModel?
    @Published var talkCategory: CategoryViewModel?
    @Published var sportsCategory: CategoryViewModel?
    @Published var locationCategory: CategoryViewModel?
    @Published var languageCategory: CategoryViewModel?
    @Published var podcastsCategory: CategoryViewModel?
    
    // From interactor:
    // MARK: Properties
    private let container = DIContainer.shared
    private let tuneInRepository: TuneInRepositoryProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Methods
    func fetchCategories() {
        clearErrorState()
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
    init(tuneInRepository: TuneInRepositoryProtocol) {
        self.tuneInRepository = tuneInRepository
    }
    
    struct CategoryViewModel {
        var type: RadioItemType
        var key: String?
        var text: String
        var url: URL?
        var imageName: String
        var color: String

        init(_ category: RadioItem) {
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
    
    func showCategories(_ categories: [RadioItem]) {
        
        for category in categories {
            switch category.key {
            case "local":
                localCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "music":
                musicCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "talk":
                talkCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "sports":
                sportsCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "location":
                locationCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "language":
                languageCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            case "podcast":
                podcastsCategory = BrowseMainCategoriesViewModel.CategoryViewModel(category)
            default: break
            }
        }

        isLoading = false
    }
    
    func showErrorState() {
        isLoading = false
        shouldShowError = true
    }
    
    func clearErrorState() {
        isLoading = true
        shouldShowError = false
    }
}

// MARK: - Private methods
private extension BrowseMainCategoriesViewModel {
    func getMainCategories() {
        tuneInRepository.getGeneralTuneInCategories()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    Logger.logError(message: error)
                    self.showErrorState()
                case .finished:
                    break
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                self.showCategories(categories)
            }
            .store(in: &subscriptions)
    }
}
