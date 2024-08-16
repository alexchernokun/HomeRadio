//
//  MyStationsScreenEvent.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 16.08.2024.
//

import Foundation
import DomainLayer

enum MyStationsScreenEvent {
    case onAppear
    case getRadioStations
    case playRadio(_ station: RadioItem)
    case onPlayButtonTap
}
