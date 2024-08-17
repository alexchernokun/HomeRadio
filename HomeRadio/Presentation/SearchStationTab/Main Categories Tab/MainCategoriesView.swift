//
//  BrowseStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import Domain

struct MainCategoriesView: View {
    
    @StateObject private var viewModel: MainCategoriesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(Colors.bgPrimary)
                    .ignoresSafeArea()
                
                if viewModel.shouldShowError {
                    NetworkErrorView {
                        viewModel.onEvent(.fetchCategories)
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        menuContainerView()
                            .padding()
                            .redacted(reason: viewModel.isLoading ? .placeholder : [])
                            .onAppear {
                                viewModel.onEvent(.fetchCategories)
                            }
                    }
                }
            }
            .navigationTitle("Find Your Tune")
        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: MainCategoriesViewModel(getCategoriesUseCase: DependencyContainer.shared.getCategoriesUseCase))
    }
}

private extension MainCategoriesView {
    
    func menuContainerView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            navigationViewItem(for: viewModel.localCategory)
            
            HStack(alignment: .center, spacing: 10) {
                navigationViewItem(for: viewModel.musicCategory)
                navigationViewItem(for: viewModel.talkCategory)
            }
            
            HStack(alignment: .center, spacing: 10) {
                navigationViewItem(for: viewModel.sportsCategory)
                navigationViewItem(for: viewModel.locationCategory)
            }
            
            HStack(alignment: .center, spacing: 10) {
                navigationViewItem(for: viewModel.languageCategory)
                navigationViewItem(for: viewModel.podcastsCategory)
            }
        }
    }
    
    @ViewBuilder
    func navigationViewItem(for category: MainCategoriesViewModel.CategoryViewModel?) -> some View {
        if let category {
            NavigationLink {
                SubCategoryView(for: category.url)
            } label: {
                categoryView(category)
            }
        }
    }
    
    func categoryView(_ category: MainCategoriesViewModel.CategoryViewModel) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(category.text)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(Colors.textPrimary))
                    .padding(.vertical, 20)
                    .padding(.leading, 20)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image(systemName: category.imageName)
                    .foregroundColor(Color(Colors.textPrimary))
                    .padding(.vertical, 20)
                    .padding(.trailing, 20)
            }
        }
        .disabled(viewModel.isLoading)
        .background(
            Rectangle()
                .fill(Color(category.color).gradient)
                .cornerRadius(25)
        )
    }
    
}

#Preview {
    MainCategoriesView()
}
