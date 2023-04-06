//
//  BrowseStationsView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 06.04.2023.
//

import SwiftUI
import DomainLayer

struct BrowseStationsView: View {
    let interactor: BrowseStationsInteractor
    @ObservedObject var viewModel: BrowseStationsViewModel
    
    var body: some View {
        ZStack {
            Color("bgPrimary")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 15) {
                categoryView(viewModel.localCategory,
                             action: interactor.navigateToLocalStations)
                
                HStack(alignment: .center, spacing: 10) {
                    categoryView(viewModel.musicCategory,
                                 action: interactor.navigateToMusic)
                    categoryView(viewModel.talkCategory,
                                 action: interactor.navigateToTalk)
                }
                
                HStack(alignment: .center, spacing: 10) {
                    categoryView(viewModel.sportsCategory,
                                 action: interactor.navigateToSports)
                    categoryView(viewModel.locationCategory,
                                 action: interactor.navigateToByLocation)
                }
                
                HStack(alignment: .center, spacing: 10) {
                    categoryView(viewModel.languageCategory,
                                 action: interactor.navigateToByLanguage)
                    categoryView(viewModel.podcastsCategory,
                                 action: interactor.navigateToPodcasts)
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

private extension BrowseStationsView {
    
    func categoryView(_ category: MainTuneInCategory?, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text(category?.text ?? "")
                        .foregroundColor(Color("textPrimary"))
                        .padding(.vertical, 40)
                    Spacer()
                }
            }
            .background(
                Rectangle()
                    .fill(Color("bgSpecial"))
                    .cornerRadius(25)
            )
        }
        .disabled(viewModel.isLoading)
    }
    
}

struct SearchStationsView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseStationsPreviewMock.view()
    }
}



//        .padding()

//        List(viewModel.categories, id: \.self) { category in
//            Text(category.text)
//        }
//        .redacted(reason: viewModel.isLoading ? .placeholder : [])
//        .onAppear {
//            interactor.fetchCategories()
//        }
