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
    static let radioPlayer = RadioPlayer()
    
    static var presenter: MyStationsPresenter {
        return MyStationsPresenter()
    }
    
    static func view() -> MyStationsView {
        let repository = ItunesSearchRepository()
        let interactor = MyStationsInteractor(presenter: presenter,
                                              radioPlayer: radioPlayer,
                                              iTunesRepository: repository)
        let view = MyStationsView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        return view
    }
}
