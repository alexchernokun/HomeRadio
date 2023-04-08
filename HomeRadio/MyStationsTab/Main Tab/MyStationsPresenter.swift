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
    @Published var isRadioPlaying: Bool = false
}

final class MyStationsPresenter {
    
    // MARK: Properties
    fileprivate(set) var viewModel = MyStationsViewModel()
    
    var isRadioPlaying: Bool {
        return viewModel.isRadioPlaying
    }
    var currentStation: RadioStation? {
        return viewModel.currentStation
    }
    
    // MARK: Methods
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
    
    func toggleIsRadioPlaying() {
        viewModel.isRadioPlaying.toggle()
        isRadioPlaying ? makeStopButton() : makePlayButton()
    }
    
    func makePlayButton() {
        viewModel.isRadioPlaying = false
    }

    func makeStopButton() {
        viewModel.isRadioPlaying = true
    }
    
    func updateMetadata(_ title: String) {
        viewModel.currentStation?.metadata = title
    }
    
    func updateArtwork(_ url: URL?) {
        viewModel.currentStation?.artworkFromMetadata = url
    }
}
