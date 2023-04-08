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
        presenter.viewModel.localCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "Local Radio"))
        presenter.viewModel.musicCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "Music"))
        presenter.viewModel.talkCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "Talk"))
        presenter.viewModel.sportsCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "Sports"))
        presenter.viewModel.locationCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "By Location"))
        presenter.viewModel.languageCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "By Language"))
        presenter.viewModel.podcastsCategory = BrowseStationsViewModel.CategoryViewModel(RadioItem(text: "Podcasts"))
        presenter.viewModel.isLoading = false
        return presenter
    }
    
    static func view() -> BrowseStationsView {
        let interactor = BrowseStationsInteractor(presenter: presenter,
                                                  tuneInRepository: TuneInRepository())
        let view = BrowseStationsView(interactor: interactor, viewModel: presenter.viewModel)
        return view
    }
}
