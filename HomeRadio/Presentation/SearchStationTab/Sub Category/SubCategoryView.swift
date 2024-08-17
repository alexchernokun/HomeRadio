//
//  SubCategoryView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import SwiftUI
import RadioPlayer
import Domain

struct SubCategoryView:  View {
    
    @StateObject private var viewModel: SubCategoryViewModel
    
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
    
    func radioItemsList() -> some View {
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
            viewModel.onEvent(.playRadio(item))
        } label: {
            RadioStationTypeView(station: item)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func navigationItemView(_ item: RadioItem) -> some View {
        NavigationLink {
            SubCategoryView(for: item.url)
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
