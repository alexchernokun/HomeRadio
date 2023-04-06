//
//  MyStationsInteractor.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import RadioPlayer

final class MyStationsInteractor {
    
    private let presenter: MyStationsPresenter
    private let radioPlayer: RadioPlayer
    
    init(presenter: MyStationsPresenter,
         radioPlayer: RadioPlayer) {
        self.presenter = presenter
        self.radioPlayer = radioPlayer
    }
}
