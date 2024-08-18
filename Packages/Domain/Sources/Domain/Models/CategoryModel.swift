//
//  CategoryModel.swift
//  Domain
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation

public struct CategoryModel {
    public var type: RadioItemType
    public var key: RadioStationItemKey
    public var text: String
    public var url: URL?
    public var imageName: String
    public var color: String
    
    public init(_ category: RadioStationItem) {
        self.type = category.type
        self.text = category.text
        self.url = category.url
        self.key = category.key

        switch key {
        case .local:
            self.imageName = "location.circle"
            self.color = Colors.categoryRed
        case .music:
            self.imageName = "music.note"
            self.color = Colors.categoryBlue
        case .talk:
            self.imageName = "waveform.and.mic"
            self.color = Colors.bgSecondary
        case .sports:
            self.imageName = "sportscourt"
            self.color = Colors.categoryOrange
        case .location:
            self.imageName = "mappin.and.ellipse"
            self.color = Colors.categoryGreen
        case .language:
            self.imageName = "globe"
            self.color = Colors.categoryYellow
        case .podcast:
            self.imageName = "mic.fill"
            self.color = Colors.categoryBrown
        default:
            self.imageName = "questionmark"
            self.color = "bgSecondary"
        }
    }
}
