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
    static var presenter: BrowseMainCategoriesPresenter {
        let presenter = BrowseMainCategoriesPresenter()
        presenter.viewModel.localCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "Local Radio"))
        presenter.viewModel.musicCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "Music"))
        presenter.viewModel.talkCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "Talk"))
        presenter.viewModel.sportsCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "Sports"))
        presenter.viewModel.locationCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "By Location"))
        presenter.viewModel.languageCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "By Language"))
        presenter.viewModel.podcastsCategory = BrowseMainCategoriesViewModel.CategoryViewModel(RadioItem(text: "Podcasts"))
        presenter.viewModel.isLoading = false
        return presenter
    }
    
    static func view() -> BrowseMainCategoriesView {
        let interactor = BrowseMainCategoriesInteractor(presenter: presenter,
                                                  tuneInRepository: TuneInRepository())
        let view = BrowseMainCategoriesView(interactor: interactor, viewModel: presenter.viewModel)
        return view
    }
}
