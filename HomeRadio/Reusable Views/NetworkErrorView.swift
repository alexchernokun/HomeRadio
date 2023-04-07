//
//  NetworkErrorView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 07.04.2023.
//

import SwiftUI
import Utils

struct NetworkErrorView: View {
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            
            Image("networkErrorImage")
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(.bottom, 20)
            
            Text("Something went wrong")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 18, weight: .semibold))
            
            HStack(alignment: .center) {
                Spacer()
                Text("Please try to refresh the page")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(Color(Colors.textSecondary))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            Button {
                
            } label: {
                Text("Refresh")
            }
            .padding(.top, 20)
            .buttonStyle(.bordered)
            
            Spacer()
        }
    }
}

struct NetworkErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkErrorView(action: nil)
    }
}
