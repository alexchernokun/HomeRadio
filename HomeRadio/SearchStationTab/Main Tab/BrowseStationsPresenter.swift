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
        var type: CategoryType
        var text: String
        var url: URL?
        var imageName: String
        var color: String
        
        init(_ category: MainTuneInCategory) {
            self.type = category.type
            self.text = category.text
            self.url = category.url
            
            switch text {
            case "Local Radio":
                self.imageName = "location.circle"
                self.color = Colors.categoryRed
            case "Music":
                self.imageName = "music.note"
                self.color = Colors.categoryBlue
            case "Talk":
                self.imageName = "waveform.and.mic"
                self.color = Colors.bgSecondary
            case "Sports":
                self.imageName = "sportscourt"
                self.color = Colors.categoryOrange
            case "By Location":
                self.imageName = "mappin.and.ellipse"
                self.color = Colors.categoryGreen
            case "By Language":
                self.imageName = "globe"
                self.color = Colors.categoryYellow
            case "Podcasts":
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
    
    func showCategories(_ categories: [MainTuneInCategory]) {
        for category in categories {
            switch category.text {
            case "Local Radio":
                viewModel.localCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "Music":
                viewModel.musicCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "Talk":
                viewModel.talkCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "Sports":
                viewModel.sportsCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "By Location":
                viewModel.locationCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "By Language":
                viewModel.languageCategory = BrowseStationsViewModel.CategoryViewModel(category)
            case "Podcasts":
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
