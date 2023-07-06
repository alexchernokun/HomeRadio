//
//  MyStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import Utils

struct MyStationsView: View {
    let interactor: MyStationsInteractor
    @ObservedObject var viewModel: MyStationsViewModel
    @State var showPopover = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(Colors.bgPrimary)
                .ignoresSafeArea()
            
            if viewModel.shouldShowEmptyState {
                MyStationsEmptyView()
            } else {
                contentView
            }
        }
        .refreshable {
            interactor.getMyStations()
        }
        .popover(isPresented: $showPopover, content: {
            PlayerView(interactor: interactor,
                       viewModel: viewModel,
                       showPopover: $showPopover)
        })
        .onAppear {
            interactor.getMyStations()
        }
    }
}

// MARK: Subviews
private extension MyStationsView {
    
    @ViewBuilder
    var contentView: some View  {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 25) {
                Text("My Favourite Tunes")
                    .foregroundColor(Color(Colors.textPrimary))
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding(.top, 40)
                    .padding(.leading, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.myStations, id: \.self) { station in
                            Button {
                                interactor.playRadio(station)
                            } label: {
                                RadioStationTypeView(station: station, isAdded: true)
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
            }
            .padding(.bottom, 95)
            
            MiniPlayerView(interactor: interactor,
                           viewModel: viewModel,
                           showPopover: $showPopover)
                .padding(.horizontal, 5)
                .padding(.bottom, 5)
        }
    }    

}

struct MyStationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyStationsPreviewMock.myStationsView()
    }
}
