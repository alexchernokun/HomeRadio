//
//  BrowseStationsPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import NetworkService
import DomainLayer

struct BrowseStationsPreviewMock {
    static var presenter: BrowseStationsPresenter {
        let presenter = BrowseStationsPresenter()
        presenter.viewModel.localCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "Local Radio", url: ""))
        presenter.viewModel.musicCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "Music", url: ""))
        presenter.viewModel.talkCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "Talk", url: ""))
        presenter.viewModel.sportsCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "Sports", url: ""))
        presenter.viewModel.locationCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "By Location", url: ""))
        presenter.viewModel.languageCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "By Language", url: ""))
        presenter.viewModel.podcastsCategory = BrowseStationsViewModel.CategoryViewModel(MainTuneInCategory(type: "", text: "Podcasts", url: ""))
        presenter.viewModel.isLoading = false
        return presenter
    }
    
    static func view() -> BrowseStationsView {
        let interactor = BrowseStationsInteractor(presenter: presenter,
                                                  tuneInRepository: MainTuneInRepository())
        let view = BrowseStationsView(interactor: interactor, viewModel: presenter.viewModel)
        return view
    }
}
