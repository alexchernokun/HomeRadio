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

struct BrowseStationsModuleBuilder: ModuleBuilder {
    typealias ViewType = BrowseStationsView
    
    var container = DIContainer.shared
    
    func build() -> BrowseStationsView {
        let presenter = BrowseStationsPresenter()
        let tuneInRepository = container.resolve(type: TuneInRepository.self)
        let interactor = BrowseStationsInteractor(presenter: presenter,
                                                  tuneInRepository: tuneInRepository)
        let view = BrowseStationsView(interactor: interactor,
                                      viewModel: presenter.viewModel)
        return view
    }
}

