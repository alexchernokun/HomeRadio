//
//  RatingView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import SwiftUI

struct RatingsView: View {
    let value: Double?
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { index in
                Image(systemName: imageName(for: index, value: value))
            }
        }
        .foregroundColor(.yellow)
    }
    
    func imageName(for starIndex: Int, value: Double?) -> String {
        let result = (value ?? 0.0) - Double(starIndex)
        switch result {
        case ..<0.5: return "star"
        case 0.5..<1.0: return "star.leadinghalf.filled"
        default: return "star.fill"
        }
    }
}

#Preview {
    RatingsView(value: 3.5)
}
