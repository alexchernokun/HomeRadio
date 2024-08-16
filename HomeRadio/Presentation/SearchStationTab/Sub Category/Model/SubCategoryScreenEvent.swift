//
//  SubCategoryScreenEvent.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 16.08.2024.
//

import Foundation
import RadioPlayer
import DomainLayer

enum SubCategoryScreenEvent {
    case configure(radioPlayer: RadioPlayer, tuneInRepository: TuneInRepository)
    case fetchRadioStations
    case playRadio(_ station: RadioItem)
    case save(_ station: RadioItem)
}
