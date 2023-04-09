//
//  BrowseStationsPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import DomainLayer
import Utils

final class BrowseStationsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var shouldShowError = false

    @Published var localCategory: CategoryViewModel?
    @Published var musicCategory: CategoryViewModel?
    @Published var talkCategory: CategoryViewModel?
    @Published var sportsCategory: CategoryViewModel?
    @Published var locationCategory: CategoryViewModel?
    @Published var languageCategory: CategoryViewModel?
    @Published var podcastsCategory: CategoryViewModel?
    
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
}

final class BrowseStationsPresenter {
    fileprivate(set) var viewModel = BrowseStationsViewModel()
    
    func showCategories(_ categories: [RadioItem]) {
        
        for category in categories {
            switch category.key {
            case "local":
                viewModel.localCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "music":
                viewModel.musicCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "talk":
                viewModel.talkCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "sports":
                viewModel.sportsCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "location":
                viewModel.locationCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "language":
                viewModel.languageCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "podcast":
                viewModel.podcastsCategory = BrowseStationsViewModel.CategoryViewModel(category)
            default: break
            }
        }

        viewModel.isLoading = false
    }
    
    func showErrorState() {
        viewModel.isLoading = false
        viewModel.shouldShowError = true
    }
    
    func clearErrorState() {
        viewModel.isLoading = true
        viewModel.shouldShowError = false
    }
}
