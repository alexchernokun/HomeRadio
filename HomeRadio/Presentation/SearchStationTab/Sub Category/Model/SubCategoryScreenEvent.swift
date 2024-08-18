//
//  SubCategoryScreenEvent.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 16.08.2024.
//

import Foundation
import RadioPlayer
import Domain

enum SubCategoryScreenEvent {
    case fetchRadioStations
    case playRadio(_ station: RadioStationItem)
}
