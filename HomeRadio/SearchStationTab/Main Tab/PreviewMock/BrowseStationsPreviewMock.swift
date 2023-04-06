//
//  BrowseStationsPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI

struct BrowseStationsPreviewMock {
    static var presenter: BrowseStationsPresenter {
        return BrowseStationsPresenter()
    }
    
    static func view() -> BrowseStationsView {
        let interactor = BrowseStationsInteractor(presenter: presenter)
        let view = BrowseStationsView(interactor: interactor, viewModel: presenter.viewModel)
        return view
    }
}
