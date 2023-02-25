//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Deni Tusha on 2/11/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
     
    var body: some View {
        VStack{
           
            HStack{
                Text(game.theme.name)
                Spacer()
                Button("New Game") {
                    game.newGame()
                }.foregroundColor(.black)
                Spacer()
                Text("Score: \(game.score)")
            }.padding(.horizontal)

//            ScrollView{
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
//                    ForEach(game.cards) { card in
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in 
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            })
                        
//                    }
//                }
//            }
            .foregroundColor(game.getColour(themeColor: game.theme.color))
            .padding(.all)
        }
    }
}
    
    
  
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                }else if card.isMatched{
                    shape.opacity(0)
                }else {
                    shape .fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}



































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
    
      
      


