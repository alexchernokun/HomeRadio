//
//  MyStationsPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import NetworkService
import RadioPlayer

struct MyStationsPreviewMock {
    private static let radioPlayer = RadioPlayer()
    private static let repository = ItunesSearchRepository()
    
    private static var presenter: MyStationsPresenter {
        return MyStationsPresenter()
    }
    
    private static var interactor: MyStationsInteractor {
        return MyStationsInteractor(presenter: presenter,
                                    radioPlayer: radioPlayer,
                                    iTunesRepository: repository)
    }
    
    static func myStationsView() -> MyStationsView {
        return MyStationsView(interactor: interactor,
                              viewModel: presenter.viewModel)
    }
    
    static func playerView() -> PlayerView {
        return PlayerView(interactor: interactor,
                          viewModel: presenter.viewModel,
                          showPopover: Binding<Bool>.constant(true))
    }
    
    static func miniPlayerView() -> MiniPlayerView {
        return MiniPlayerView(interactor: interactor,
                              viewModel: presenter.viewModel,
                              showPopover: Binding<Bool>.constant(false))
    }
}
