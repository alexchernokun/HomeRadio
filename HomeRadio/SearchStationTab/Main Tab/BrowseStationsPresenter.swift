//
//  BrowseStationsPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import DomainLayer

final class BrowseStationsViewModel: ObservableObject {
    var isLoading = true

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
                self.color = "bgSecondary"
            case "Music":
                self.imageName = "music.note"
                self.color = "bgSecondary"
            case "Talk":
                self.imageName = "waveform.and.mic"
                self.color = "bgSecondary"
            case "Sports":
                self.imageName = "sportscourt"
                self.color = "bgSecondary"
            case "By Location":
                self.imageName = "mappin.and.ellipse"
                self.color = "bgSecondary"
            case "By Language":
                self.imageName = "globe"
                self.color = "bgSecondary"
            case "Podcasts":
                self.imageName = "mic.fill"
                self.color = "bgSecondary"
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
}
