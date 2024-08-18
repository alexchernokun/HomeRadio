//
//  MyRadioStationView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import SwiftUI
import Domain
import Foundation

struct MyRadioStationView: View {
    
    var station: RadioStationItem
    var action: ((RadioStationItem) -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            artwork()
            metadata()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
    
}

// MARK: Subviews
private extension MyRadioStationView {
    
    @ViewBuilder
    func artwork() -> some View {
        AsyncImage(url: station.image) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(SquircleShape(size: 75))
                    .padding(.leading, 15)
                    .padding(.trailing, 5)
            } else {
                Color(Colors.bgSecondary)
                    .frame(width: 75, height: 75)
                    .clipShape(SquircleShape(size: 75))
            }
        }
    }
    
    @ViewBuilder
    func metadata() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(station.text)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(Colors.textPrimary))
            Text(station.subtext ?? "")
                .font(.system(size: 11, weight: .light))
                .foregroundColor(Color(Colors.textSecondary))
            
            Spacer()
                .frame(height: 10)
            
            rating(station.popularity)
        }
        .padding(.vertical)
        .padding(.trailing, 10)
        .lineLimit(0)
    }
    
    @ViewBuilder
    func rating(_ popularity: Double?) -> some View {
        RatingsView(value: popularity)
    }
}

#Preview {
    MyRadioStationView(station: PreviewMockDataProvider.station)
}
