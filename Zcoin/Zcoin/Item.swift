//
//  Item.swift
//  Zcoin
//
//  Created by Zamin Orucov on 3/19/26.
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
