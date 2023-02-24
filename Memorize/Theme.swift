//
//  Theme.swift
//  Memorize
//
//  Created by Deni Tusha on 2/23/23.
//

import Foundation

struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairsToShow: Int?
    var color: String
}

let Themes: [Theme] = [
    Theme(name: "Travel Cards",
          emojis: [ "🚁", "✈️", "🏎","🚙","🚌","🚓","🛻",
                    "🚑","🚚","🚜","🏍","🚆","🚲","🛸",
                    "🚤","🛺","🛵"],
          numberOfPairsToShow: 3,
          color: "blue"),
    Theme(name: "Flag Cards",
          emojis: ["🏳️", "🏴", "🏴‍☠️", "🇦🇱", "🇦🇹", "🇨🇦",
                   "🇫🇴", "🇪🇹", "🇪🇺", "🇫🇰", "🇬🇷", "🇬🇹",
                   "🇩🇪", "🇰🇷", "🇯🇵", "🇺🇸", "🇨🇭" ],
          numberOfPairsToShow: 6,
          color: "yellow"),
    Theme(name: "Fruit Cards",
          emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉",
                    "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭",
                    "🍍", "🥕", "🥑"  ],
          numberOfPairsToShow: 5,
          color: "green")
]
