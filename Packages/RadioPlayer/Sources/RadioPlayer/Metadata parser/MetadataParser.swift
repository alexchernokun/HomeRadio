//
//  File.swift
//
//
//  Created by Oleksandr Chornokun on 1/30/22.
//

import Foundation
import AVFoundation

public struct MetadataParser {
    public static func getTitle(from metadata: [AVTimedMetadataGroup]) -> String {
        guard let items = metadata.first?.items else { return "" }
        let title = parseGeneralResponse(from: items)
        return title ?? ""
    }
}

private extension MetadataParser {
    static func parseGeneralResponse(from items: [AVMetadataItem]) -> String? {
        var title: String?
        for item in items {
            guard let key = item.key else { return nil}
            
            switch key as? String {
            // General metadata response
            case "StreamTitle":
                title = item.value as? String
            default:
                break
            }
        }
        return title
    }
    
}
