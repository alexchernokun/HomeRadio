//
//  LinkTypeView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import SwiftUI
import Domain

struct LinkTypeView: View {
    
    var stationItem: RadioItem
    var action: ((RadioItem) -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(stationItem.text)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(Colors.textPrimary))
        }
        .lineLimit(0)
    }
}
