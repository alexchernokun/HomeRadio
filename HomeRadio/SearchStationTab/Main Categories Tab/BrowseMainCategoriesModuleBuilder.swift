//
//  BrowseStationsModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import NetworkService
import Utils

struct BrowseMainCategoriesModuleBuilder: ModuleBuilder {
    typealias ViewType = BrowseMainCategoriesView
    
    var container = DIContainer.shared
    
    func build() -> BrowseMainCategoriesView {
        let presenter = BrowseMainCategoriesPresenter()
        let tuneInRepository = container.resolve(type: TuneInRepositoryProtocol.self)
        let interactor = BrowseMainCategoriesInteractor(presenter: presenter,
                                                        tuneInRepository: tuneInRepository)
        let view = BrowseMainCategoriesView(interactor: interactor,
                                            viewModel: presenter.viewModel)
        return view
    }
}

