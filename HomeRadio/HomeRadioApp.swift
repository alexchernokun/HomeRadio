//
//  HomeRadioApp.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import SwiftUI
import Utils
import RadioPlayer

@main
struct HomeRadioApp: App {
    
    @StateObject private var radioPlayer = RadioPlayer()
    private var tuneInRepository = TuneInRepository()
    private var itunesRepository = ItunesSearchRepository()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MyStationsView(viewModel: MyStationsViewModel(radioPlayer: radioPlayer,
                                                              iTunesRepository: itunesRepository))
                    .tabItem {
                        Label("My Stations", systemImage: "music.note.list")
                    }

                MainCategoriesView(viewModel: MainCategoriesViewModel(tuneInRepository: tuneInRepository))
                    .tabItem {
                        Label("Browse", systemImage: "antenna.radiowaves.left.and.right")
                    }
            }
            .onAppear {
                // fix for the transparency bug of Tab bars
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
            .environmentObject(radioPlayer)
            .environmentObject(tuneInRepository)
            .environmentObject(itunesRepository)
        }
    }
}
