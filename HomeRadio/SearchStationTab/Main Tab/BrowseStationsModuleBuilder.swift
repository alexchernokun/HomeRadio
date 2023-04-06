//
//  BrowseStationsModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import Utils

struct BrowseStationsModuleBuilder: ModuleBuilder {
    typealias ViewType = BrowseStationsView
    
    var container = DIContainer.shared
    
    func build() -> BrowseStationsView {
        let presenter = BrowseStationsPresenter()
        let interactor = BrowseStationsInteractor(presenter: presenter)
        let view = BrowseStationsView(interactor: interactor,
                                      viewModel: presenter.viewModel)
        return view
    }
}

