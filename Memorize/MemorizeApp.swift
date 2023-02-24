//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Deni Tusha on 2/11/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
