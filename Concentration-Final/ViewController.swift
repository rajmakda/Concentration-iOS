//
//  ViewController.swift
//  Concentration-Final
//
//  Created by Raj Makda on 2/6/18.
//  Copyright © 2018 Raj Makda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(noOfPairs: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var scoreCounterLabel: UILabel!
    @IBOutlet weak var flipCounterLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchedCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.pickCard(at: cardNumber)
            syncUIWithModel()
        } else {
                print("Card that is clicked is not found")
        }
    }
    
    func syncUIWithModel() {
        for i in 0..<cardButtons.count {
            let cardButton = cardButtons[i]
            let card = game.cards[i]
            if card.isFaceUp {
                cardButton.setTitle(setEmoji(for: card), for: UIControlState.normal)
                cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cardButton.setTitle("", for: UIControlState.normal)
                if card.isMatch {
                    cardButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0)
                    cardButton.isEnabled = false
                } else {
                    cardButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                }
            }
        }
        flipCounterLabel.text = "Flip Count: \(game.flipCount)"
        scoreCounterLabel.text = "Score: \(game.score)"
    }
    lazy var emojiChoices = pickEmojiTheme()
    var emojis = Dictionary<Int, String>()
    
    func setEmoji(for card: Card) -> String {
        if emojis[card.id] == nil, emojiChoices.count > 0 {
            let random = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojis[card.id] = emojiChoices.remove(at: random)
        }
        return emojis[card.id] ?? "?"
    }
    
    func enableAllCards() {
        for index in cardButtons.indices {
            cardButtons[index].isEnabled = true
        }
    }
    
    func pickEmojiTheme() -> [String] {
        var emojiThemes = Dictionary<Int, [String]>()
        emojiThemes[0] = ["✈️","🏍","🚗","🛸","🚌","🚞","🛳","🚀","🚂","🛴","🚜","🚁","🛶","🚛"]
        emojiThemes[1] = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏹","🎱","🏓","🏸","🥅","🏒","🏑","🏏"]
        emojiThemes[2] = ["🍎","🍐","🍊","🍓","🍕","🍗","🍟","🍔","🥗","🍱","🍿","🍪","🍭","🌯"]
        emojiThemes[3] = ["😘","😋","😂","🙃","😍","🤓","😎","😞","😇","😡","😱","🤢","😈","😊"]
        emojiThemes[4] = ["🐶","🐱","🐭","🐹","🦊","🐻","🐼","🐯","🐝","🐴","🦋","🐔","🐸","🐵"]
        let rand = Int(arc4random_uniform(UInt32(emojiThemes.count)))
            return emojiThemes[rand] ?? ["?"]
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        game = Concentration(noOfPairs: (cardButtons.count + 1) / 2)
        emojiChoices = pickEmojiTheme()
        emojis.removeAll()
        enableAllCards()
        syncUIWithModel()
    }
}
