//
//  Item.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/1/24.
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
