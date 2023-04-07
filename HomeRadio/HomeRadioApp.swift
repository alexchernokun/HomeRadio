//
//  HomeRadioApp.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import SwiftUI
import Utils

@main
struct HomeRadioApp: App {
    
    let container = DIContainer.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                container.resolve(type: MyStationsModuleBuilder.self).build()
                    .tabItem {
                        Label("My Stations", systemImage: "music.note.list")
                    }
                container.resolve(type: BrowseStationsModuleBuilder.self).build()
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
        }
    }
    
    init() {
        DIContainerInitialization()
    }
}
