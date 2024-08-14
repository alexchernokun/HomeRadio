//
//  SubCategoryView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import SwiftUI
import DomainLayer
import Utils

struct SubCategoryView:  View {
    
    @ObservedObject var viewModel: SubCategoryViewModel
    
    var body: some View {
        if viewModel.shouldShowError {
            NetworkErrorView {
                viewModel.fetchRadioStationItems()
            }
        } else {
            radioItemsList()
                .buttonStyle(.bordered)
                .listStyle(.sidebar)
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .redacted(reason: viewModel.isLoading ? .placeholder : [])
                .onAppear {
                    viewModel.fetchRadioStationItems()
                }
        }
    }
}

private extension SubCategoryView {
    
    func radioItemsList() -> some View {
        List(viewModel.radioItems, id: \.self) { radioItem in
            if let children = radioItem.children {
                Section(header: Text(radioItem.text)) {
                    ForEach(children, id: \.self) { child in
                        viewForItem(item: child)
                    }
                }
            } else {
                viewForItem(item: radioItem)
            }
            
        }
    }
    
    @ViewBuilder
    func viewForItem(item: RadioItem) -> some View {
        switch item.type {
        case .audio:
            radioItemView(item)
        case .link:
            navigationItemView(item)
        default:
            emptyState()
        }
    }
    
    func radioItemView(_ item: RadioItem) -> some View {
        Button {
            viewModel.playRadio(item)
        } label: {
            RadioStationTypeView(station: item) { station in
                viewModel.saveToMyStations(station)
            }
        }
        .buttonStyle(.plain)
    }
    
    func navigationItemView(_ item: RadioItem) -> some View {
        NavigationLink {
            viewModel.navigateToLink(item)
        } label: {
            LinkTypeView(stationItem: item)
        }
    }
    
    func emptyState() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("No stations or shows available")
                .foregroundColor(Color(Colors.textPrimary))
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SubCategoryPreviewMock.view()
    }
}
