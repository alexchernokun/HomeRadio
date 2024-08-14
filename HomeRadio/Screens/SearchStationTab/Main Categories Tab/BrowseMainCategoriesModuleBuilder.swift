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
        let tuneInRepository = container.resolve(type: TuneInRepositoryProtocol.self)
        let viewModel = BrowseMainCategoriesViewModel(tuneInRepository: tuneInRepository)
        let view = BrowseMainCategoriesView(viewModel: viewModel)
        return view
    }
}

