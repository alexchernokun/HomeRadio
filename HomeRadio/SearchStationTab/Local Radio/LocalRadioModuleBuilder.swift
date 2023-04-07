//
//  LocalRadioModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import Utils

struct LocalRadioModuleBuilder: ModuleBuilder {
    typealias ViewType = LocalRadioView
    
    var container = DIContainer.shared
    
    func build() -> ViewType {
        let presenter = LocalRadioPresenter()
        let localRadioRepository = container.resolve(type: LocalRadioRepository.self)
        let radioPlayer = container.resolve(type: RadioPlayer.self)
        let interactor = LocalRadioInteractor(presenter: presenter,
                                              localRadioRepository: localRadioRepository,
                                              radioPlayer: radioPlayer)
        let view = LocalRadioView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        return view
    }
}
