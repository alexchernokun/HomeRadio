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
    static var viewModel: BrowseMainCategoriesViewModel {
        return BrowseMainCategoriesViewModel(tuneInRepository: TuneInRepository())
    }
    
    static func view() -> BrowseMainCategoriesView {
        let view = BrowseMainCategoriesView(viewModel: viewModel)
        return view
    }
}
