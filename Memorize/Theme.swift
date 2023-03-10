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
          emojis: [ "π", "βοΈ", "π","π","π","π","π»",
                    "π","π","π","π","π","π²","πΈ",
                    "π€","πΊ","π΅"],
          numberOfPairsToShow: 8,
          color: "blue"),
    Theme(name: "Flag Cards",
          emojis: ["π³οΈ", "π΄", "π΄ββ οΈ", "π¦π±", "π¦πΉ", "π¨π¦",
                   "π«π΄", "πͺπΉ", "πͺπΊ", "π«π°", "π¬π·", "π¬πΉ",
                   "π©πͺ", "π°π·", "π―π΅", "πΊπΈ", "π¨π­" ],
          numberOfPairsToShow: 12,
          color: "yellow"),
    Theme(name: "Fruit Cards",
          emojis: ["π", "π", "π", "π", "π", "π", "π",
                    "π", "π", "π«", "π", "π", "π", "π₯­",
                    "π", "π₯", "π₯"  ],
          numberOfPairsToShow: 10,
          color: "green")
]
