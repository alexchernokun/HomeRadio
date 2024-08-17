//
//  RadioPlayer.swift
//  RadioPlayer
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import UIKit
import AVFoundation
import Combine
import AppLogger
import MediaPlayer

/// General purpose Radio Player module which plays stream from url and also can fetch station metadata
public final class RadioPlayer: NSObject, ObservableObject {
    
    // MARK: Properties
    public var trackTitle = CurrentValueSubject<String, Never>("")
    @Published var isPaused: Bool = true
    
    // MARK: Private Properties
    private let player = AVPlayer()
    private var playerItemContext = 0
    
    // MARK: Public methods
    /// Play Radio URL
    /// - Parameter url: url for a playback
    public func playRadio(from url: URL) {
        player.pause()
        setupPlayer(with: url)
        player.play()
        isPaused = false
    }
    
    /// Pause Radio URL
    public func pauseRadio() {
        player.pause()
        isPaused = true
    }
    
    // Playback Observer
    override public func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            // Switch over status value
            switch status {
            case .readyToPlay:
                AppLogger.log("ReadyToPlay", type: .debug)
            case .failed:
                AppLogger.log("FaledToPlay", type: .debug)
            case .unknown:
                AppLogger.log("ReadyTUnknownToPlayoPlay", type: .debug)
            @unknown default:
                AppLogger.log("NewUnknownToPlay", type: .debug)
            }
        }
    }

    // MARK: Initialization
    public override init() {
        super.init()
        enableBackgroundPlayback()
        setupRemoteCommandCenter()
    }
}

// MARK: Private methods
private extension RadioPlayer {
    func enableBackgroundPlayback() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            AppLogger.log("Setting category to AVAudioSessionCategoryPlayback failed", type: .error)
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    func setupPlayer(with url: URL) {
        let playerAsset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: playerAsset)
        let metadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metadataOutput.setDelegate(self, queue: DispatchQueue.main)
        playerItem.add(metadataOutput)
        
        playerItem.addObserver(self,
                               forKeyPath: #keyPath(AVPlayerItem.status),
                               options: [.old, .new],
                               context: &playerItemContext)
        
        player.replaceCurrentItem(with: playerItem)
    }
    
    func toggleRadioPlayback() {
        isPaused ? player.play() : player.pause()
        isPaused.toggle()
    }
}

// MARK: Remote Command Center Setup
private extension RadioPlayer {
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(play))
        commandCenter.pauseCommand.addTarget(self, action: #selector(pause))
    }
    
    @objc func play() -> MPRemoteCommandHandlerStatus {
        toggleRadioPlayback()
        return .success
    }
    
    @objc func pause() -> MPRemoteCommandHandlerStatus {
        toggleRadioPlayback()
        return .success
    }
}

// MARK: Metadata delegate conformance
extension RadioPlayer: AVPlayerItemMetadataOutputPushDelegate {
    public func metadataOutput(_ output: AVPlayerItemMetadataOutput,
                               didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup],
                               from track: AVPlayerItemTrack?) {
        
        trackTitle.value = MetadataParser.getTitle(from: groups)

        AppLogger.logMetadata(groups: groups,
                           title: trackTitle.value,
                           track: track,
                           level: .short)
    }
}
