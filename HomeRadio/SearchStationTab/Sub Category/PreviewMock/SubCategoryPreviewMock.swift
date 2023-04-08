//
//  SubCategoryPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import DomainLayer

struct SubCategoryPreviewMock {
    static var presenter: SubCategoryPresenter {
        let presenter = SubCategoryPresenter()
        presenter.viewModel.isLoading = false
        return presenter
    }
    
    static func view() -> SubCategoryView {
        let interactor = SubCategoryInteractor(presenter: presenter,
                                               tuneInRepository: TuneInRepository(),
                                               radioPlayer: RadioPlayer(),
                                               path: "",
                                               query: ["": ""])
        let view = SubCategoryView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        return view
    }
}
