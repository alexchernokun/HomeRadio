//
//  PlayerView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.07.2023.
//

import SwiftUI
import Utils

struct PlayerView: View {
    let interactor: MyStationsInteractor
    @ObservedObject var viewModel: MyStationsViewModel
    @Binding var showPopover: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            background()
            
            artwork()
                
            metadata()
            
            playPauseButton()
            
            Spacer()
        }
    }
}

// MARK: Subviews
private extension PlayerView {
    func background() -> some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 60, height: 8)
            .foregroundColor(Color(Colors.textPrimary))
            .padding(.top, 15)
            .padding(.bottom, 40)
    }
    
    func artwork() -> some View {
        if let artwork = viewModel.currentStation?.artworkFromMetadata {
            return asyncImage(artwork)
        } else {
            return asyncImage(viewModel.currentStation?.image)
        }
    }
    
    func metadata() -> some View {
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
    }
    
    func playPauseButton() -> some View {
        Button {
            interactor.toggleRadioPlayback()
        } label: {
            Image(systemName: viewModel.isRadioPlaying ? "stop.fill" : "play.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(Colors.bgSpecial))
        }
        .padding(.top, 30)
    }
    
    func asyncImage(_ url: URL?) -> some View {
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

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MyStationsPreviewMock.playerView()
    }
}
