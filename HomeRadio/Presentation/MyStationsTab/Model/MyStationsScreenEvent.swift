//
//  MyStationsScreenEvent.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 16.08.2024.
//

import Foundation
import Domain

enum MyStationsScreenEvent {
    case onAppear
    case getMyRadioStations
    case playRadio(_ station: RadioItem)
    case onPlayButtonTap
}
