//
//  Item.swift
//  macOS Window Styler
//
//  Created by Sean on 2026/7/3.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
