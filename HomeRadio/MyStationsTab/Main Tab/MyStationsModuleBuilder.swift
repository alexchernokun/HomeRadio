//
//  MyStationsModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import Utils

struct MyStationsModuleBuilder: ModuleBuilder {
    typealias ViewType = MyStationsView
    
    var container = DIContainer.shared
    
    func build() -> MyStationsView {
        let presenter = MyStationsPresenter()
        let interactor = MyStationsInteractor(presenter: presenter,
                                              radioPlayer: container.resolve(type: RadioPlayer.self))
        
        let view = MyStationsView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        
        return view
    }
}
