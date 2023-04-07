//
//  LocalRadioView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer

struct LocalRadioView: View {
    let interactor: LocalRadioInteractor
    @ObservedObject var viewModel: LocalRadioViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(viewModel.stations, id: \.self) { station in
                    Button {
                        interactor.playRadio(from: station.url)
                    } label: {
                        RadioStationView(station: station)
                    }
                }
            }
        }
        .navigationTitle("Local Radio")
        .navigationBarTitleDisplayMode(.inline)
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .onAppear {
            interactor.fetchLocalRadioStations()
        }        
    }
}

struct LocalRadioView_Previews: PreviewProvider {
    static var previews: some View {
        LocalRadioPreviewMock.view()
    }
}
