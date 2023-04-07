//
//  LocalRadioPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import DomainLayer

struct LocalRadioPreviewMock {
    static var presenter: LocalRadioPresenter {
        let presenter = LocalRadioPresenter()
        presenter.viewModel.isLoading = false
        return presenter
    }
    
    static func view() -> LocalRadioView {
        let interactor = LocalRadioInteractor(presenter: presenter,
                                              localRadioRepository: LocalRadioRepository(),
                                              radioPlayer: RadioPlayer())
        let view = LocalRadioView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        return view
    }
}
