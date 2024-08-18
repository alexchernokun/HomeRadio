//
//  MiniPlayerView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.07.2023.
//

import SwiftUI
import Domain

struct MiniPlayerView: View {
    
    @ObservedObject var viewModel: MyStationsViewModel
    @Binding var showPopover: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            artwork()
            metadata()
            Spacer()
            playPauseButton()
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
}

// MARK: Subviews
private extension MiniPlayerView {
    func artwork() -> some View {
        if let artwork = viewModel.currentStation?.artworkFromMetadata {
            return asyncImage(artwork)
        } else {
            return asyncImage(viewModel.currentStation?.image)
        }
    }
    
    func metadata() -> some View {
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
                    .lineLimit(1)
            }
        }
    }
    
    func playPauseButton() -> some View {
        Button {
            viewModel.onEvent(.onPlayButtonTap)
        } label: {
            Image(systemName: viewModel.isRadioPlaying ? "stop.fill" : "play.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color(Colors.textSecondary))
                .padding(.trailing, 25)
        }
    }
    
    func asyncImage(_ url: URL?) -> some View {
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
}

#Preview {
    MiniPlayerView(viewModel: MyStationsViewModel(getMyStationsUseCase: DependencyContainer.shared.getMyStationsUseCase,
                                                  getRadioStationTagsUseCase: DependencyContainer.shared.getRadioStationTagsUseCase,
                                                  filterRadioStationsByTagsUseCase: DependencyContainer.shared.filterStationsByTagsUseCase,
                                                  sortRadioStationsByRatingUseCase: DependencyContainer.shared.sortStationsByRatingUseCase,
                                                  getTrackArtworkUseCase: DependencyContainer.shared.getTrackArtworkUseCase,
                                                  radioPlayer: DependencyContainer.shared.radioPlayer),
                   showPopover: .constant(false))
}
