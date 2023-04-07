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
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.shouldShowEmptyState {
                MyStationsEmptyView()
            } else {
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
                                    RadioStationView(station: station, state: .added)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 85)
                
                Button {
                    showPopover = true
                } label: {
                    nowPlayingSmallView()
                        .padding(.horizontal, 5)
                        .padding(.bottom, 5)
                }
                
            }
            
        }
        .refreshable {
            interactor.getMyStations()
        }
        .popover(isPresented: $showPopover, content: {
            Text("Hello")
        })
        .onAppear {
            interactor.getMyStations()
        }
    }
}

private extension MyStationsView {
    
    private func nowPlayingSmallView() -> some View {
        HStack(alignment: .center, spacing: 3) {
            AsyncImage(url: viewModel.currentStation?.image) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 65, height: 65)
                        .clipShape(SquircleShape(size: 65))
                        .padding(10)
                } else {
                    Color(Colors.textSecondary)
                        .frame(width: 65, height: 65)
                        .clipShape(SquircleShape(size: 65))
                        .padding(10)
                }
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.currentStation?.text ?? "Choose the station to play")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(Colors.textPrimary))
                if let metadata = viewModel.currentStation?.metadata {
                    Text(metadata)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color(Colors.textSecondary))
                } else {
                    Text(viewModel.currentStation?.subtext ?? "")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color(Colors.textSecondary))
                }
            }
            
            Spacer()
        }
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged({ value in
                if value.translation.height < 0 {
                    showPopover = true
                }
            }))
        .background(
            Rectangle()
                .fill(Color(Colors.bgSpecial))
                .cornerRadius(25)
        )
    }
}

struct MyStationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyStationsPreviewMock.view()
    }
}
