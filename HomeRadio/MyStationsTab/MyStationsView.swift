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
                contentView
                
                nowPlayingSmallView()
                    .padding(.horizontal, 5)
                    .padding(.bottom, 5)
            }
        }
        .refreshable {
            interactor.getMyStations()
        }
        .popover(isPresented: $showPopover, content: {
            nowPlayingView()
        })
        .onAppear {
            interactor.getMyStations()
        }
    }
}

private extension MyStationsView {
    
    @ViewBuilder
    private var contentView: some View  {
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
    }
    
    private func nowPlayingSmallView() -> some View {
        HStack(alignment: .center, spacing: 3) {
            if let artwork = viewModel.currentStation?.artworkFromMetadata {
                asyncImageSmall(artwork)
            } else {
                asyncImageSmall(viewModel.currentStation?.image)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.currentStation?.text ?? "Choose the station to play")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(Colors.textPrimary))
                if let metadata = viewModel.currentStation?.metadata {
                    Text(metadata)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color(Colors.textSecondary))
                        .lineLimit(0)
                } else {
                    Text(viewModel.currentStation?.subtext ?? "")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color(Colors.textSecondary))
                }
            }
            
            Spacer()
            
            Button {
                interactor.toggleRadioPlayback()
            } label: {
                Image(systemName: viewModel.isRadioPlaying ? "stop.fill" : "play.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color(Colors.textSecondary))
                    .padding(.trailing, 25)
            }
        }
        .background(
            Rectangle()
                .fill(Color(Colors.bgSpecial))
                .cornerRadius(25)
                .onTapGesture {
                    showPopover = true
                }
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        if value.translation.height < -20 {
                            showPopover = true
                        }
                    }))
        )
    }
    
    private func nowPlayingView() -> some View {
        VStack(alignment: .center, spacing: 30) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 60, height: 8)
                .foregroundColor(Color(Colors.textPrimary))
                .padding(.top, 15)
                .padding(.bottom, 40)
            
            if let artwork = viewModel.currentStation?.artworkFromMetadata {
                asyncImageLarge(artwork)
            } else {
                asyncImageLarge(viewModel.currentStation?.image)
            }
            
            VStack(alignment: .center, spacing: 6) {
                if let metadata = viewModel.currentStation?.metadata {
                    Text(metadata)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(Colors.textPrimary))
                } else {
                    Text(viewModel.currentStation?.subtext ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(Colors.textPrimary))
                }
                Text(viewModel.currentStation?.text ?? "Choose the station to play")
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color(Colors.textSecondary))
            }
            .multilineTextAlignment(.center)
            .lineLimit(0)
            
            Button {
                interactor.toggleRadioPlayback()
            } label: {
                Image(systemName: viewModel.isRadioPlaying ? "stop.fill" : "play.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(Colors.bgSpecial))
            }
            .padding(.top, 30)
            
            Spacer()
        }
    }
    
    private func asyncImageSmall(_ url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: 65, height: 65)
                    .clipShape(SquircleShape(size: 65))
                    .padding(10)
            } else {
                ZStack(alignment: .center) {
                    Color(Colors.textSecondary)
                        .frame(width: 65, height: 65)
                        .clipShape(SquircleShape(size: 65))
                        .padding(10)
                    Image(systemName: "radio")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(Colors.bgPrimary))
                }
            }
        }
    }
    
    private func asyncImageLarge(_ url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: 320, height: 320)
                    .cornerRadius(20)
                    .padding(10)
            } else {
                ZStack(alignment: .center) {
                    Color(Colors.textSecondary)
                    Image(systemName: "radio")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(Colors.bgPrimary))
                }
                .frame(width: 320, height: 320)
                .cornerRadius(20)
                .padding(.top, 50)
            }
        }
    }
}

struct MyStationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyStationsPreviewMock.view()
    }
}
