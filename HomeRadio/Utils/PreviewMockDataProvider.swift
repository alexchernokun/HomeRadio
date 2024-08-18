//
//  PreviewMockDataProvider.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 18.08.2024.
//

import Foundation
import Domain

struct PreviewMockDataProvider {
    static var station = RadioStationItem(type: "audio",
                                          key: "",
                                          text: "Хіт FM 101.7 (Top 40 & Pop Music)",
                                          url: "http://opml.radiotime.com/Tune.ashx?id=s142760",
                                          bitrate: "128",
                                          reliability: "99",
                                          popularity: 99,
                                          subtext: "Тільки хіти!",
                                          formats: "mp3",
                                          image: "http://cdn-profiles.tunein.com/s6122/images/logoq.png?t=1",
                                          currentTrack: "",
                                          playing: "",
                                          playingImage: "",
                                          children: [],
                                          tags: nil)
}
