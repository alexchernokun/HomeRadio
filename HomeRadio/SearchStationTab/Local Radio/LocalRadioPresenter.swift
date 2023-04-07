//
//  LocalRadioPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import DomainLayer

final class LocalRadioViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var shouldShowError = false
    
    @Published var stations: [RadioStation] = []
}

final class LocalRadioPresenter {
    fileprivate(set) var viewModel = LocalRadioViewModel()
    
    func showLocalStations(_ stations: [RadioStation]) {
        viewModel.stations = stations
        viewModel.isLoading = false
    }
    
    func showErrorState() {
        viewModel.isLoading = false
        viewModel.shouldShowError = true
    }
    
    func clearErrorState() {
        viewModel.isLoading = true
        viewModel.shouldShowError = false
    }
}
