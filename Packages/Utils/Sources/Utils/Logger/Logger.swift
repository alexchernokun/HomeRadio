//
//  RadioPlayerService.swift
//  Radio
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation
import SwiftUI
import AVFoundation

/// Defines a level of logger
///
/// - error: for different errors
/// - debug: in case you need to debug something
/// - network: only for network requests/responses
/// - info: different information
public enum LoggerType: String {
    case error = "[‼️ Error]"
    case debug = "[🐞 Debug]"
    case network = "[🛰 Network]"
    case info = "[ℹ️ Info]"
    case metadata = "[🎸 Metadata]:"
}

public enum LoggerLevel {
    case short
    case verbose
}

/// General purpose Logger
public struct Logger {
        
    // MARK: Public methods
    
    /// Error message log
    /// - Parameters:
    ///   - message: some message you wish to log
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logError(message: Any,
                                fileName: String = #file,
                                line: Int = #line,
                                funcName: String = #function) {
        let type = LoggerType.error.rawValue
        let file = parse(fileName)
        Logger.printLog("\(date) \(type) [\(file)]:\(line) \(funcName) -> \(message)")
    }
    
    /// Debug message log
    /// - Parameters:
    ///   - message: some message you wish to log
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logDebug(message: Any,
                                fileName: String = #file,
                                line: Int = #line,
                                funcName: String = #function) {
        let type = LoggerType.debug.rawValue
        let file = parse(fileName)
        Logger.printLog("\(date) \(type) [\(file)]:\(line) \(funcName) -> \(message)")
    }
    
    /// Network message log
    /// - Parameters:
    ///   - message: some message you wish to log
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logNetwork(_ object: Any,
                                  fileName: String = #file,
                                  line: Int = #line,
                                  funcName: String = #function) {
        let type = LoggerType.network.rawValue
        let file = parse(fileName)
        Logger.printLog("\(date) \(type) [\(file)]:\(line) \(funcName) -> \(object)")
    }
    
    /// Info message log
    /// - Parameters:
    ///   - message: some message you wish to log
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logInfo(message: Any,
                               fileName: String = #file,
                               line: Int = #line,
                               funcName: String = #function) {
        let type = LoggerType.info.rawValue
        let file = parse(fileName)
        Logger.printLog("\(date) \(type) [\(file)]:\(line) \(funcName) -> \(message)")
    }
    
    /// Metadata message log
    /// - Parameters:
    ///   - message: some message you wish to log
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logMetadata(groups: [AVTimedMetadataGroup],
                                   title: String?,
                                   track: AVPlayerItemTrack?,
                                   fileName: String = #file,
                                   line: Int = #line,
                                   funcName: String = #function,
                                   logLevel: LoggerLevel = .verbose) {
        let type = LoggerType.metadata.rawValue
        switch logLevel {
        case .short:
            if let title = title {
                Logger.printLog("\(date) \(type) -> \(title)")
            } else {
                Logger.printLog("\(date) \(type) -> \("No metadata or couldn't parse it correctly")")
            }
        case .verbose:
            if let track = track {
                Logger.printLog("\(date) \(type) -> \(track)")
            }
            Logger.printLog("\(date) \(type) -> \(groups)")
            if let title = title {
                Logger.printLog("\(date) \(type) -> \(title)")
            } else {
                Logger.printLog("\(date) \(type) -> \("No metadata or couldn't parse it correctly")")
            }
        }

    }
    
    // MARK: Initialization
    public init() {}
}

private extension Logger {
    
    // MARK: Properties
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    static var date: String {
        return Logger.dateFormatter.string(from: Date())
    }
    
    // MARK: Private Methods
    static func printLog(_ object: Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }
    
    static func parse(_ filename: String) -> String {
        let components = filename.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
}
