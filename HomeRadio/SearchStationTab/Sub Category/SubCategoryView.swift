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
    let interactor: SubCategoryInteractor
    @ObservedObject var viewModel: SubCategoryViewModel
    
    var body: some View {
        if viewModel.shouldShowError {
            NetworkErrorView {
                interactor.fetchRadioStationItems()
            }
        } else {
            List(viewModel.stationItems, id: \.self) { stationItem in
                if let children = stationItem.children {
                    Section(header: Text(stationItem.text)) {
                        ForEach(children, id: \.self) { child in
                            viewForItem(item: child)
                        }
                    }
                } else {
                    viewForItem(item: stationItem)
                }
                
            }
            .buttonStyle(.bordered)
            .listStyle(.sidebar)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .redacted(reason: viewModel.isLoading ? .placeholder : [])
            .onAppear {
                interactor.fetchRadioStationItems()
            }
        }
    }
}

private extension SubCategoryView {
    @ViewBuilder
    func viewForItem(item: RadioItem) -> some View {
        switch item.type {
        case .audio:
            Button {
                interactor.playRadio(item)
            } label: {
                RadioStationTypeView(station: item) { station in
                    interactor.saveToMyStations(station)
                }
            }
            .buttonStyle(.plain)
        case .link:
            NavigationLink {
                interactor.navigateToLink(item)
            } label: {
                LinkTypeView(stationItem: item)
            }
        default:
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Text("No stations or shows available")
                    .foregroundColor(Color(Colors.textPrimary))
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SubCategoryPreviewMock.view()
    }
}
