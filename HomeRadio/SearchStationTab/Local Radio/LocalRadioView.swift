//
//  LocalRadioView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer

struct LocalRadioView: View {
    let category: MainTuneInCategory
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LocalRadioView_Previews: PreviewProvider {
    static var previews: some View {
        LocalRadioView(category: MainTuneInCategory(type: "", text: "", url: ""))
    }
}
