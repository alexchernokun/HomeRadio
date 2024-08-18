//
//  MyStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import Domain

struct MyStationsView: View {
    
    @StateObject private var viewModel: MyStationsViewModel
    @State var showPopover = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(Colors.bgPrimary)
                .ignoresSafeArea()
            
            if viewModel.myStations.isEmpty {
                emptyView()
            } else {
                contentView()
            }
        }
        .refreshable {
            viewModel.onEvent(.getMyRadioStations)
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
        _viewModel = StateObject(wrappedValue: MyStationsViewModel(getMyStationsUseCase: DependencyContainer.shared.getMyStationsUseCase,
                                                                   getRadioStationTagsUseCase: DependencyContainer.shared.getRadioStationTagsUseCase,
                                                                   filterRadioStationsByTagsUseCase: DependencyContainer.shared.filterStationsByTagsUseCase,
                                                                   sortRadioStationsByRatingUseCase: DependencyContainer.shared.sortStationsByRatingUseCase,
                                                                   getTrackArtworkUseCase: DependencyContainer.shared.getTrackArtworkUseCase,
                                                                   radioPlayer: DependencyContainer.shared.radioPlayer))
        self.showPopover = showPopover
    }
}

// MARK: Subviews
private extension MyStationsView {
    
    @ViewBuilder
    func contentView() -> some View {
        if viewModel.shouldShowError {
            VStack(alignment: .leading, spacing: 0) {
                header()
                NetworkErrorView {
                    viewModel.onEvent(.getMyRadioStations)
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 0) {
                header()
                myStations()
                MiniPlayerView(viewModel: viewModel,
                               showPopover: $showPopover)
                .padding(.horizontal, 5)
                .padding(.bottom, 5)
            }
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("My Favourite Tunes")
                    .foregroundColor(Color(Colors.textPrimary))
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .layoutPriority(1)
                
                if !viewModel.myStations.isEmpty {
                    Menu {
                        Button("Ascending") {
                            withAnimation { viewModel.onEvent(.sort(.asc)) }
                        }
                        Button("Descending") {
                            withAnimation { viewModel.onEvent(.sort(.desc)) }
                        }
                        Divider()
                        Button("Reset") {
                            withAnimation { viewModel.onEvent(.sort(.none)) }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 16, weight: .bold))
                            .tint(Color(Colors.textPrimary))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.top, 40)
            
            tags()
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func myStations() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(viewModel.myStations, id: \.self) { station in
                    radioStationRow(station)
                }
            }
        }
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func tags() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.radioStationTags, id: \.name) { tag in
                    Button {
                        withAnimation { viewModel.onEvent(.onTagToggle(tag)) }
                    } label: {
                        Text(tag.name)
                            .font(.system(size: 14, weight: .medium))
                            .padding(5)
                            .background(tag.isToggled ? Colors.selectedTagColor : Colors.unselectedTagColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func radioStationRow(_ station: RadioStationItem) -> some View {
        Button {
            viewModel.onEvent(.playRadio(station))
        } label: {
            MyRadioStationView(station: station)
                .background(
                    Rectangle()
                        .fill(Color(Colors.bgSecondary))
                        .cornerRadius(25)
                )
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func emptyView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            header()
            MyStationsEmptyView()
        }
    }
}

#Preview {
    MyStationsView()
}
