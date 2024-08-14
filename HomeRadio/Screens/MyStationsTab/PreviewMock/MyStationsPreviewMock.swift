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
    
    private static var viewModel: MyStationsViewModel {
        return MyStationsViewModel(radioPlayer: radioPlayer,
                                   iTunesRepository: repository)
    }
    
    static func myStationsView() -> MyStationsView {
        return MyStationsView(viewModel: viewModel)
    }
    
    static func playerView() -> PlayerView {
        return PlayerView(viewModel: viewModel,
                          showPopover: Binding<Bool>.constant(true))
    }
    
    static func miniPlayerView() -> MiniPlayerView {
        return MiniPlayerView(viewModel: viewModel,
                              showPopover: Binding<Bool>.constant(false))
    }
}
