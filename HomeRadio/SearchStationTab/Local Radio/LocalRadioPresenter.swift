//
//  LocalRadioPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import DomainLayer

final class LocalRadioViewModel: ObservableObject {
    var isLoading = true
    
    @Published var stations: [RadioStation] = []
}

final class LocalRadioPresenter {
    fileprivate(set) var viewModel = LocalRadioViewModel()
    
    func showLocalStations(_ stations: [RadioStation]) {
        viewModel.stations = stations
        viewModel.isLoading = false
        print(stations)
    }
}
