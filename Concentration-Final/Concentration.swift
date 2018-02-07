//
//  Concentration.swift
//  Concentration-Final
//
//  Created by Raj Makda on 2/7/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import Foundation

class Concentration {

    var cards = Array<Card>()
    var faceUpIndex: Int?
    var score = 0
    var flipCount = 0
    
    init(noOfPairs: Int) {
        score = 0
        flipCount = 0
        cards.removeAll()
        for _ in 0..<noOfPairs {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        //TODO: shuffle cards
        var last = cards.count - 1
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, rand)
            last -= 1
        }
    }
    
    func pickCard(at index:Int) {
        flipCount += 1
        if !cards[index].isMatch {
            if let matchIndex = faceUpIndex, matchIndex != index {
                //checking if cards are matching
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                    score += 1
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
                faceUpIndex = nil
            } else {
            //2 cards are face up or no card is face up
                for i in 0..<cards.count {
                    cards[i].isFaceUp = false
                }
                cards[index].isFaceUp = true
                faceUpIndex = index
            }
        }
    }

}
