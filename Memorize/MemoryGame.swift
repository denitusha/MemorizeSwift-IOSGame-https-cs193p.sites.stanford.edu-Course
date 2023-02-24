//
//  MemoryGame.swift
//  Memorize
//
//  Created by Deni Tusha on 2/13/23.
//

import Foundation


struct MemoryGame <CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }else{
                    if cards[chosenIndex].isSeen == true{
                        score -= 1
                    }
                    if cards[potentialMatchIndex].isSeen == true{
                        score -= 1
                    }
                }
                cards[chosenIndex].isSeen = true
                cards[potentialMatchIndex].isSeen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else {
                
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfcards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfcards {
            let content = createCardContent(pairIndex )
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        var isSeen: Bool = false
        let id: Int
        
    }
}
