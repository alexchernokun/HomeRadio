//
//  MyStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI

struct MyStationsView: View {
    
    @StateObject private var viewModel: MyStationsViewModel
    @State var showPopover = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(Colors.bgPrimary)
                .ignoresSafeArea()
            
            if viewModel.myStations.isEmpty {
                MyStationsEmptyView()
            } else {
                contentView
            }
        }
        .refreshable {
            viewModel.onEvent(.getRadioStations)
        }
        .popover(isPresented: $showPopover, content: {
            PlayerView(viewModel: viewModel,
                       showPopover: $showPopover)
        })
        .onAppear {
            viewModel.onEvent(.onAppear)
        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: MyStationsViewModel(radioPlayer: DependencyContainer.shared.radioPlayer,
                                                                   getTrackArtworkUseCase: DependencyContainer.shared.getTrackArtworkUseCase))
        self.showPopover = showPopover
    }
}

// MARK: Subviews
private extension MyStationsView {
    
    @ViewBuilder
    var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My Favourite Tunes")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 32, weight: .bold, design: .default))
                .padding(.top, 40)
                .padding(.leading, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.myStations, id: \.self) { station in
                        Button {
                            viewModel.onEvent(.playRadio(station))
                        } label: {
                            RadioStationTypeView(station: station)
                                .background(
                                    Rectangle()
                                        .fill(Color(Colors.bgSecondary))
                                        .cornerRadius(25)
                                )
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.bottom, 10)
            
            MiniPlayerView(viewModel: viewModel,
                           showPopover: $showPopover)
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
        }
    }
}

#Preview {
    MyStationsView()
}
