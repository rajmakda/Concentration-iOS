//
//  Card.swift
//  Concentration-Final
//
//  Created by Raj Makda on 2/7/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatch = false
    var id: Int
    
    static var idGenerator = 0
    
    init() {
        self.id = Card.getUniqueId()
    }
    
    static func getUniqueId() -> Int {
        idGenerator += 1
        return idGenerator
    }
}
