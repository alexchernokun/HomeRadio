//
//  MyStationsEmptyView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import SwiftUI

struct MyStationsEmptyView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            
            Image("emptyStateImage")
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(.bottom, 20)
            
            Text("Your Stations List is Empty")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 18, weight: .semibold))
            
            HStack(alignment: .center) {
                Spacer()
                Text("Search for your favourite radio stations in Browse tab and tap Add button")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Color(Colors.textSecondary))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    MyStationsEmptyView()
}
