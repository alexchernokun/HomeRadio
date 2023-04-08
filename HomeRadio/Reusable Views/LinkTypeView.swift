//
//  LinkTypeView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import SwiftUI
import DomainLayer
import Utils

struct LinkTypeView: View {
    
    var stationItem: RadioItem
    var action: ((RadioItem) -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(stationItem.text)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(Colors.textPrimary))
                .padding(.leading, 15)
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .padding(.trailing, 15)
        }
        .padding(.vertical)
        .lineLimit(0)
        .background(
            Rectangle()
                .fill(Color(Colors.bgSecondary))
                .cornerRadius(25)
        )
        .padding(.horizontal)
    }
}

struct LinkTypeView_Previews: PreviewProvider {
    static var previews: some View {
        LinkTypeView(stationItem: RadioItem(text: ""), action: nil)
    }
}
