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

    @Published var localCategory: MainTuneInCategory?
    @Published var musicCategory: MainTuneInCategory?
    @Published var talkCategory: MainTuneInCategory?
    @Published var sportsCategory: MainTuneInCategory?
    @Published var locationCategory: MainTuneInCategory?
    @Published var languageCategory: MainTuneInCategory?
    @Published var podcastsCategory: MainTuneInCategory?
}

final class BrowseStationsPresenter {
    fileprivate(set) var viewModel = BrowseStationsViewModel()
    
    func showCategories(_ categories: [MainTuneInCategory]) {
        for category in categories {
            switch category.text {
            case "Local Radio": viewModel.localCategory = category
            case "Music": viewModel.musicCategory = category
            case "Talk": viewModel.talkCategory = category
            case "Sports": viewModel.sportsCategory = category
            case "By Location": viewModel.locationCategory = category
            case "By Language": viewModel.languageCategory = category
            case "Podcasts": viewModel.podcastsCategory = category
            default: break
            }
        }

        viewModel.isLoading = false
    }
}
