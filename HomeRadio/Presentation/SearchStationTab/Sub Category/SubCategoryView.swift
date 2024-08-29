//
//  SubCategoryView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import SwiftUI
import Domain

struct SubCategoryView:  View {
    
    @StateObject private var viewModel: SubCategoryViewModel
    @State var showPopover = false
    
    var body: some View {
        if viewModel.shouldShowError {
            NetworkErrorView {
                viewModel.onEvent(.fetchRadioStations)
            }
        } else {
            radioItemsList()
                .buttonStyle(.bordered)
                .listStyle(.sidebar)
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
                .redacted(reason: viewModel.isLoading ? .placeholder : [])
                .onAppear {
                    viewModel.onEvent(.fetchRadioStations)
                }
        }
    }
    
    init(for url: URL?) {
        if let url {
            let viewModel = SubCategoryViewModel(radioPlayer: DependencyContainer.shared.radioPlayer,
                                                 getSubcategoriesUseCase: DependencyContainer.shared.getSubcategoriesUseCase,
                                                 path: URLExtractHelper.extractPathFrom(url),
                                                 query:  URLExtractHelper.extractQueryFrom(url))
            _viewModel = StateObject(wrappedValue: viewModel)
        } else {
            let viewModel = SubCategoryViewModel(radioPlayer: DependencyContainer.shared.radioPlayer,
                                                 getSubcategoriesUseCase: DependencyContainer.shared.getSubcategoriesUseCase)
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    }
}

private extension SubCategoryView {
    
    @ViewBuilder
    func radioItemsList() -> some View {
        VStack {
            List(viewModel.subcategoryItems, id: \.self) { radioItem in
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
            MiniPlayerView(currentStation: $viewModel.currentStation,
                           isRadioPlaying: $viewModel.isRadioPlaying,
                           showPopover: $showPopover)
        }
        .popover(isPresented: $showPopover, content: {
            PlayerView(currentStation: $viewModel.currentStation,
                       isRadioPlaying: $viewModel.isRadioPlaying,
                       showPopover: $showPopover)
        })
    }
    
    @ViewBuilder
    func viewForItem(item: RadioStationItem) -> some View {
        switch item.type {
        case .audio:
            radioItemView(item)
        case .link:
            navigationItemView(item)
        default:
            emptyState()
        }
    }
    
    @ViewBuilder
    func radioItemView(_ item: RadioStationItem) -> some View {
        Button {
            viewModel.onEvent(.playRadio(item))
        } label: {
            RadioStationTypeView(station: item)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func navigationItemView(_ item: RadioStationItem) -> some View {
        NavigationLink {
            SubCategoryView(for: item.url)
        } label: {
            LinkTypeView(stationItem: item)
        }
    }
    
    @ViewBuilder
    func emptyState() -> some View {
        Text("No stations or shows available")
            .foregroundColor(Color(Colors.textPrimary))
            .font(.system(size: 18, weight: .semibold))
            .frame(maxHeight: .infinity, alignment: .center)
    }
}
