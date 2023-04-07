//
//  BrowseStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer
import Utils

struct BrowseStationsView: View {
    let interactor: BrowseStationsInteractor
    @ObservedObject var viewModel: BrowseStationsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(Colors.bgPrimary)
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.shouldShowError {
                    NetworkErrorView {
                        interactor.fetchCategories()
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 15) {
                            NavigationLink {
                                interactor.navigateToLocalStations()
                            } label: {
                                categoryView(viewModel.localCategory)
                            }
                            
                            HStack(alignment: .center, spacing: 10) {
                                categoryView(viewModel.musicCategory)
                                categoryView(viewModel.talkCategory)
                            }
                            
                            HStack(alignment: .center, spacing: 10) {
                                categoryView(viewModel.sportsCategory)
                                categoryView(viewModel.locationCategory)
                            }
                            
                            HStack(alignment: .center, spacing: 10) {
                                categoryView(viewModel.languageCategory)
                                categoryView(viewModel.podcastsCategory)
                            }
                        }
                        .padding()
                        .redacted(reason: viewModel.isLoading ? .placeholder : [])
                        .onAppear {
                            interactor.fetchCategories()
                    }
                    }
                }
                
            }
            .navigationTitle("Find Your Tune")
        }
    }
}

private extension BrowseStationsView {
    
    func categoryView(_ category: BrowseStationsViewModel.CategoryViewModel?) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(category?.text ?? "")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(Colors.textPrimary))
                    .padding(.vertical, 20)
                    .padding(.leading, 20)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image(systemName: category?.imageName ?? "")
                    .foregroundColor(Color(Colors.textPrimary))
                    .padding(.vertical, 20)
                    .padding(.trailing, 20)
            }
        }
        .disabled(viewModel.isLoading)
        .background(
            Rectangle()
                .fill(Color(category?.color ?? "").gradient)
                .cornerRadius(25)
        )
    }
    
}

struct SearchStationsView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseStationsPreviewMock.view()
    }
}
