//
//  NetworkErrorView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import SwiftUI
import Domain

struct NetworkErrorView: View {
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("networkErrorImage")
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(.bottom, 20)
            Text("Something went wrong")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 18, weight: .semibold))
            Text("Please try to refresh the page")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(Color(Colors.textSecondary))
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            Button {
                action?()
            } label: {
                Text("Refresh")
            }
            .padding(.top, 20)
            .buttonStyle(.bordered)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    NetworkErrorView()
}
