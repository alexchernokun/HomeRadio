//
//  AppLogger.swift
//  AppLogger
//
//  Created by Oleksandr Chornokun on 04.04.2023.
//

import Foundation
import AVFoundation
import OSLog

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
    case metadata = "[🎸 Metadata]"
}

public enum LoggerLevel {
    case short
    case verbose
}

/// General purpose Logger
public struct AppLogger {
    
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "HomeRadioSubsystem",
                                category: "HomeRadio")
    
    // MARK: Public methods
    
    /// Object message log
    /// - Parameters:
    ///   - object: some object or message you wish to log
    ///   - type: the logger type (info, debug, network, etc)
    ///   - level: short or verbose
    ///   - fileName: filename where log was executed
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    static public func log(_ object: Any,
                           type: LoggerType,
                           level: LoggerLevel = .verbose,
                           fileName: String = #file,
                           line: Int = #line,
                           funcName: String = #function) {
        let file = parse(fileName)
        switch level {
        case .short:
            AppLogger.printLog("\(date) \(type.rawValue) -> \(object)", type: type)
        case .verbose:
            AppLogger.printLog("\(date) \(type.rawValue) [\(file)]:\(line) \(funcName) -> \(object)", type: type)
        }
    }
    
    /// Metadata message log
    /// - Parameters:
    ///   - groups: metadata groups array
    ///   - title: track title if available
    ///   - track: AVPlayerItemTrack entity
    ///   - fileName: filename where log was executed
    ///   - level: short or verbose
    ///   - line: line where log was executed
    ///   - funcName: function name where log was executed
    public static func logMetadata(groups: [AVTimedMetadataGroup],
                                   title: String?,
                                   track: AVPlayerItemTrack?,
                                   level: LoggerLevel = .verbose,
                                   fileName: String = #file,
                                   line: Int = #line,
                                   funcName: String = #function) {
        let type = LoggerType.metadata.rawValue
        switch level {
        case .short:
            if let title = title {
                AppLogger.printLog("\(date) \(type) -> \(title)", type: .metadata)
            } else {
                AppLogger.printLog("\(date) \(type) -> \("No metadata or couldn't parse it correctly")", type: .metadata)
            }
        case .verbose:
            if let track = track {
                AppLogger.printLog("\(date) \(type) -> \(track)", type: .metadata)
            }
            AppLogger.printLog("\(date) \(type) -> \(groups)", type: .metadata)
            if let title = title {
                AppLogger.printLog("\(date) \(type) -> \(title)", type: .metadata)
            } else {
                AppLogger.printLog("\(date) \(type) -> \("No metadata or couldn't parse it correctly")", type: .metadata)
            }
        }
        
    }
    
    // MARK: Initialization
    public init() {}
}

private extension AppLogger {
    
    // MARK: Properties
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    static var date: String {
        return AppLogger.dateFormatter.string(from: Date())
    }
    
    // MARK: Private Methods
    static func printLog(_ object: String, type: LoggerType) {
        #if DEBUG
        switch type {
        case .error:
            logger.error("\(object)")
        case .debug:
            logger.debug("\(object)")
        case .network, .info, .metadata:
            logger.info("\(object)")
        }
        #endif
    }
    
    static func parse(_ filename: String) -> String {
        let components = filename.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
