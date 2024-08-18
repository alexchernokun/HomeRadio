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
    
    var firstRowRange: Range<Int> { 1..<3 }
    var secondRowRange: Range<Int> { 3..<5 }
    var thirdRowRange: Range<Int> { 5..<7 }
    
    @ViewBuilder
    func menuContainerView() -> some View {
        if !viewModel.globalCategories.isEmpty {
            Grid(alignment: .center,
                 horizontalSpacing: 10,
                 verticalSpacing: 12) {
                navigationViewItem(for: viewModel.localCategory)
                
                GridRow {
                    ForEach(1..<3) { index in
                        navigationViewItem(for: viewModel.globalCategories[index])
                    }
                }
                GridRow {
                    ForEach(3..<5) { index in
                        navigationViewItem(for: viewModel.globalCategories[index])
                    }
                }
                GridRow {
                    ForEach(5..<7) { index in
                        navigationViewItem(for: viewModel.globalCategories[index])
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func navigationViewItem(for category: CategoryModel?) -> some View {
        if let category {
            NavigationLink {
                SubCategoryView(for: category.url)
            } label: {
                categoryView(category)
            }
        }
    }
    
    func categoryView(_ category: CategoryModel) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(category.text)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(Colors.textPrimary))
                .padding(.vertical, 20)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: category.imageName)
                .foregroundColor(Color(Colors.textPrimary))
                .padding(.vertical, 20)
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .trailing)
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
