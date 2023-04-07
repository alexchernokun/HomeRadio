//
//  MyStationsPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import Foundation
import DomainLayer

final class MyStationsViewModel: ObservableObject {
    @Published var myStations: [RadioStation] = []
    @Published var shouldShowEmptyState = false
    @Published var currentStation: RadioStation?
}

final class MyStationsPresenter {
    
    fileprivate(set) var viewModel = MyStationsViewModel()
    
    func showEmptyState() {
        viewModel.shouldShowEmptyState = true
    }
    
    func showMyStations(_ stations: [RadioStation]) {
        viewModel.shouldShowEmptyState = false
        viewModel.myStations = stations
    }
    
    func updateCurrentStation(_ station: RadioStation) {
        viewModel.currentStation = station
    }
    
    func updateMetadata(_ title: String) {
        viewModel.currentStation?.metadata = title
    }
}
