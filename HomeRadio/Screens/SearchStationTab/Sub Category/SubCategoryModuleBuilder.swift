//
//  SubCategoryModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import Utils

struct SubCategoryModuleBuilder: ModuleBuilder {
    typealias ViewType = SubCategoryView
    
    var container = DIContainer.shared
    
    var path: String
    var query: [String: String?]
    
    func build() -> SubCategoryView {
        let radioPlayer = container.resolve(type: RadioPlayer.self)
        let tuneInRepository = container.resolve(type: TuneInRepositoryProtocol.self)
        let viewModel = SubCategoryViewModel(tuneInRepository: tuneInRepository,
                                             radioPlayer: radioPlayer,
                                             path: path,
                                             query: query)
        let view = SubCategoryView(viewModel: viewModel)
        return view
    }
    
}
