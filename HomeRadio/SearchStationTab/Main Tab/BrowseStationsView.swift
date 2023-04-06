//
//  BrowseStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI

struct BrowseStationsView: View {
    let interactor: BrowseStationsInteractor
    @ObservedObject var viewModel: BrowseStationsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SearchStationsView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseStationsPreviewMock.view()
    }
}
