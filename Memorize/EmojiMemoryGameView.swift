//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Deni Tusha on 2/11/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
     
    var body: some View {
        VStack{
           
            HStack{
                Text(viewModel.theme.name)
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }.foregroundColor(.black)
                Spacer()
                Text("Score: \(viewModel.score)")
            }.padding(.horizontal)

            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.getColour(themeColor: viewModel.theme.color))
            .padding(.all)
        }
    }
}
    
    
  
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }else if card.isMatched{
                shape.opacity(0)
            }else {
                shape .fill()
            }
        }
    }
}



































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
    
      
      


