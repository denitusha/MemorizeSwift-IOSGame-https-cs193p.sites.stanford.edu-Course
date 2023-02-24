//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Deni Tusha on 2/14/23.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
  
    private static func creatememoryGame (theme: Theme) -> MemoryGame<String> {
        let emojis: Array<String> = theme.emojis.shuffled()
        var cardsToShow: Int = theme.numberOfPairsToShow ?? emojis.count
        if cardsToShow > emojis.count{
            cardsToShow = emojis.count
        }
        return MemoryGame<String>(numberOfPairsOfcards: cardsToShow) { pairIndex in
            emojis[pairIndex]
            
        }
    }
    
    func getColour(themeColor: String) ->  Color {
        switch themeColor{
        case "blue":
            return Color.blue
        case "yellow":
            return Color.yellow
        case "green":
            return Color.green
        default:
            return Color.red
        }
    }
    
    
    
    private(set) var theme: Theme
    @Published private var model: MemoryGame<String>
    
     var score: Int {
        return model.score
    }
    
    init(startingTheme: Theme? = nil) {
        let selectedTheme = startingTheme ?? Themes.randomElement()!
        theme = selectedTheme
        model = EmojiMemoryGame.creatememoryGame(theme: theme)
    }
    
    
    func newGame(startingTheme: Theme? = nil) {
        let selectedTheme = startingTheme ?? Themes.randomElement()!
        theme = selectedTheme
        model = EmojiMemoryGame.creatememoryGame(theme: theme)
    }
    
    var cards: Array<Card>{
         model.cards
    }
    
    // Mark: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
}
