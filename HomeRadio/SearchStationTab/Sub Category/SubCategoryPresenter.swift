//
//  SubCategoryPresenter.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import Foundation
import DomainLayer

final class SubCategoryViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var shouldShowError = false
    
    @Published var title: String = ""
    @Published var stationItems: [RadioItem] = []
}

final class SubCategoryPresenter {
    fileprivate(set) var viewModel = SubCategoryViewModel()
    
    func showItems(_ title: String?, _ stations: [RadioItem]) {
        viewModel.isLoading = false
        viewModel.title = title ?? "Title"
        viewModel.stationItems = stations
    }
    
    func showErrorState() {
        viewModel.isLoading = false
        viewModel.shouldShowError = true
    }
    
    func clearErrorState() {
        viewModel.isLoading = true
        viewModel.shouldShowError = false
    }
}
