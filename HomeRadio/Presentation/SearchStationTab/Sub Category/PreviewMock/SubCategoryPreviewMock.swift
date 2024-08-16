//
//  SubCategoryPreviewMock.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 08.04.2023.
//

import Foundation
import SwiftUI
import RadioPlayer
import NetworkService
import DomainLayer

struct SubCategoryPreviewMock {
    
    private static var rockLinkChildren: [RadioItem] {
        return [RadioItem(type: .link, text: "Hard Rock"),
                RadioItem(type: .link, text: "Metal"),
                RadioItem(type: .link, text: "Classic Rock")]
    }
    
    private static var jazzRadioChildren: [RadioItem] {
        return [RadioItem(type: .audio, text: "Smooth Jazz"),
                RadioItem(type: .audio, text: "Classic Jazz Hits"),
                RadioItem(type: .audio, text: "Chill 'n' Lounge")]
    }
    
    private static var radioItems: [RadioItem] {
        return [RadioItem(type: .link, text: "Radio Rock", children: rockLinkChildren),
                RadioItem(type: .link, text: "Radio Jazz", children: jazzRadioChildren),
                RadioItem(type: .link, text: "Radio Best Hits"),
                RadioItem(type: .link, text: "Pop Radio Century"),
                RadioItem(type: .link, text: "World Classic Radio"),
                RadioItem(type: .link, text: "Christmas Oldies")]
    }
    
    private static var viewModel: SubCategoryViewModel {
        return SubCategoryViewModel(path: "",
                                    query: ["": ""])
    }
    
    static func view() -> SubCategoryView {
        return SubCategoryView()
    }
}
