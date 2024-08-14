//
//  BrowseStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer
import Utils

struct BrowseMainCategoriesView: View {
    
    @ObservedObject var viewModel: BrowseMainCategoriesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(Colors.bgPrimary)
                    .ignoresSafeArea()
                
                if viewModel.shouldShowError {
                    NetworkErrorView {
                        viewModel.fetchCategories()
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        menuContainerView()
                            .padding()
                            .redacted(reason: viewModel.isLoading ? .placeholder : [])
                            .onAppear {
                                viewModel.fetchCategories()
                            }
                    }
                }
            }
            .navigationTitle("Find Your Tune")
        }
    }
}

private extension BrowseMainCategoriesView {
    
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
    func navigationViewItem(for category: BrowseMainCategoriesViewModel.CategoryViewModel?) -> some View {
        if let category {
            NavigationLink {
                viewModel.navigateToLink(category.url)
            } label: {
                categoryView(category)
            }
        }
    }
    
    func categoryView(_ category: BrowseMainCategoriesViewModel.CategoryViewModel) -> some View {
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

struct SearchStationsView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseStationsPreviewMock.view()
    }
}
