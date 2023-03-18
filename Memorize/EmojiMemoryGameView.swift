//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Deni Tusha on 2/11/23.
//

import SwiftUI

extension VerticalAlignment {
    enum CustomBottom : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.bottom]
        }
    }

    static let customBottom = VerticalAlignment(CustomBottom.self)
}

extension View {
    func customVerticalAlignment(_ value: CGFloat) -> some View {
        self.alignmentGuide(.customBottom) { d in
            d[VerticalAlignment.bottom] + value
        }
    }
}

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
     
    var body: some View {
        
        ZStack(alignment: .init(horizontal: .center, vertical: .customBottom )){
            VStack{
                
                gameBody
                    .padding(.all)
                buttons
            }
            deckBody
                .customVerticalAlignment(30)
             
        }
        
    }
    
    var buttons: some View {
        HStack{
            Text(game.theme.name)
            Spacer()
            Button("New Game") {
                withAnimation{
                    game.newGame()
                    undeal()
                }
            }
            Spacer()
            Button("Shuffle") {
                withAnimation(.easeInOut){
                    game.shuffle()
                }
            }
            Spacer()
            Text("Score: \(game.score)")
        }.padding(.horizontal)
    }
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func undeal(){
        dealt = []
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0  )
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if isUndealt(card) || ( card.isMatched && !card.isFaceUp){
                Color.clear
            }else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)){
                            game.choose(card)
                        }
                    }
            }
        })
        .foregroundColor(game.getColour(themeColor: game.theme.color))
    }
    
    var deckBody: some View{
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtheight)
        .foregroundColor(game.getColour(themeColor: game.theme.color)  )
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)){
                    deal(card)
            }
            
        }
                
    }
}

    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDuration: Double = 2
        static let undealtheight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtheight * aspectRatio
    }
    
}
    
    
  
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack {
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(6)
                .opacity(0.4)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(Animation.easeIn(duration: 1).repeatCount(2), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                        
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    
    
    private func scale(thatFits size: CGSize) -> CGFloat{
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    private struct DrawingConstants{

        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
    }
}



































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
    
      
      


