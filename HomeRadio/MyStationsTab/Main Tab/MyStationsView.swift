//
//  MyStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI

struct MyStationsView: View {
    let interactor: MyStationsInteractor
    @ObservedObject var viewModel: MyStationsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MyStationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyStationsPreviewMock.view()
    }
}
