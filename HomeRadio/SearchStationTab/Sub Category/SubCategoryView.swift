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
        ZStack(alignment: .top) {
            Color(Colors.bgPrimary)
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.shouldShowError {
                NetworkErrorView {
                    interactor.fetchRadioStationItems()
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.stationItems, id: \.self) { stationItem in
                            switch stationItem.type {
                            case .audio:
                                Button {
                                    interactor.playRadio(from: stationItem.url)
                                } label: {
                                    RadioStationTypeView(station: stationItem) { station in
                                        interactor.saveToMyStations(station)
                                    }
                                }
                            case .link:
                                NavigationLink {
                                    interactor.navigateToLink(stationItem)
                                } label: {
                                    LinkTypeView(stationItem: stationItem)
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
                }
                .padding(.top, 15)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .onAppear {
            interactor.fetchRadioStationItems()
        }
    }
}

struct SubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SubCategoryPreviewMock.view()
    }
}
