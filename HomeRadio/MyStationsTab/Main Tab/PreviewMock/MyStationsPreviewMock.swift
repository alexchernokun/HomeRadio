//
//  MyStationsPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer

struct MyStationsPreviewMock {
    static let radioPlayer = RadioPlayer()
    
    static var presenter: MyStationsPresenter {
        return MyStationsPresenter()
    }
    
    static func view() -> MyStationsView {
        let interactor = MyStationsInteractor(presenter: presenter,
                                              radioPlayer: radioPlayer)
        let view = MyStationsView(interactor: interactor,
                                  viewModel: presenter.viewModel)
        return view
    }
}
