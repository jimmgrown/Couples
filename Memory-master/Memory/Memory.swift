//
//  Memory.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import Foundation

class Memory {
    
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched {
            return
        }
    
        if let matchIndex = indexOfFaceUpCard, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = nil
            let deadLineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline:deadLineTime){
                self.cards[index].isFaceUp = false
                self.cards[matchIndex].isFaceUp = false
            }
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = index
        }
    }
    var chaosIndex = 0
    init(numberOfPairsOfCrads: Int) {
        for _ in 1...numberOfPairsOfCrads {
            let card = Card()
            cards += [card, card]
        }
        for _ in 1...numberOfPairsOfCrads {
            let chaosCards = cards[chaosIndex*2+1]
            cards[chaosIndex*2+1] = cards[numberOfPairsOfCrads * 2 - 1 - chaosIndex]
            cards[numberOfPairsOfCrads * 2 - 1 - chaosIndex] = chaosCards
            chaosIndex+=1
        }
    }
    
    
    
}
