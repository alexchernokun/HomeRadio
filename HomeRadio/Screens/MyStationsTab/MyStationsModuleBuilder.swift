//
//  MyStationsModuleBuilder.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import Utils

struct MyStationsModuleBuilder: ModuleBuilder {
    typealias ViewType = MyStationsView
    
    var container = DIContainer.shared
    
    func build() -> MyStationsView {
        let viewModel = MyStationsViewModel(radioPlayer: container.resolve(type: RadioPlayer.self),
                                            iTunesRepository: container.resolve(type: ItunesSearchRepositoryProtocol.self))
        let view = MyStationsView(viewModel: viewModel)
        return view
    }
}
