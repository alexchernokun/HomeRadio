//
//  HomeRadioApp.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import SwiftUI

@main
struct HomeRadioApp: App {
    
    private var myStationsViewTitle = "My Stations"
    private var myStationsViewLabel = "music.note.list"
    private var categoriesViewTitle = "Browse"
    private var categoriesViewLabel = "antenna.radiowaves.left.and.right"
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MyStationsView()
                    .tabItem {
                        Label(myStationsViewTitle,
                              systemImage: myStationsViewLabel)
                    }

                MainCategoriesView()
                    .tabItem {
                        Label(categoriesViewTitle,
                              systemImage: categoriesViewLabel)
                    }
            }
        }
    }
}
