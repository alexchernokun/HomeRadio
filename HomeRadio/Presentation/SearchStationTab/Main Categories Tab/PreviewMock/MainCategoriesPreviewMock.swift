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

struct MainCategoriesPreviewMock {
    static var viewModel: MainCategoriesViewModel {
        return MainCategoriesViewModel(tuneInRepository: TuneInRepository())
    }
    
    static func view() -> MainCategoriesView {
        let view = MainCategoriesView(viewModel: viewModel)
        return view
    }
}
