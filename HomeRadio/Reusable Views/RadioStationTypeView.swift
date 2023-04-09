//
//  RadioStationView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer
import Utils

struct RadioStationTypeView: View {
    
    var station: RadioItem
    var state: State = .notAdded
    var action: ((RadioItem) -> Void)?
    
    enum State {
        case added
        case notAdded
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: station.image) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(SquircleShape(size: 75))
                        .padding(10)
                } else {
                    Color(Colors.bgSecondary)
                        .frame(width: 75, height: 75)
                        .clipShape(SquircleShape(size: 75))
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(station.text)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(Colors.textPrimary))
                Text(station.subtext ?? "")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color(Colors.textSecondary))
                
                Spacer()
                
                HStack(alignment: .center, spacing: 7) {
                    labelInfo(text: station.reliability, imageName: "cellularbars")
                    labelInfo(text: station.bitrate, imageName: "arrow.up.arrow.down")
                    labelInfo(text: station.formats, imageName: "music.note")
                }
            }
            .padding(.vertical)
            .lineLimit(0)
            
            Spacer()
            
            if state == .notAdded {
                addButton()
                    .padding(.trailing, 15)
            }
            
        }
        .background(
            Rectangle()
                .fill(Color(Colors.bgSecondary))
                .cornerRadius(25)
        )
        .padding(.horizontal)
        
    }
    
}

private extension RadioStationTypeView {
    func labelInfo(text: String?, imageName: String) -> some View {
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 8, height: 8)
            Text(text ?? "")
                .font(.system(size: 9, weight: .medium))
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .foregroundColor(Color(Colors.textSecondary))
        .background(
            Rectangle()
                .fill(Color(Colors.bgPrimary))
                .cornerRadius(25)
        )
    }
    
    func addButton() -> some View {
        Button {
            action?(station)
        } label: {
            Text("Add")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Rectangle()
                        .fill(Color(Colors.bgSpecial))
                        .cornerRadius(20)
                )
        }
    }
}

struct RadioStation_Previews: PreviewProvider {
    static var station: RadioItem {
        return RadioItem(type: "audio",
                         key: "",
                         text: "Хіт FM 101.7 (Top 40 & Pop Music)",
                         url: "http://opml.radiotime.com/Tune.ashx?id=s142760",
                         bitrate: "128",
                         reliability: "99",
                         subtext: "Тільки хіти!",
                         formats: "mp3",
                         image: "http://cdn-profiles.tunein.com/s6122/images/logoq.png?t=1",
                         currentTrack: "",
                         playing: "",
                         playingImage: "",
                         children: [])
    }
    
    static var previews: some View {
        RadioStationTypeView(station: station)
            .frame(width: 380, height: 100)
    }
}
