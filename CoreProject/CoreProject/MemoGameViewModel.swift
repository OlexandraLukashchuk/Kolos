//
//  MemoGameViewModel.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

 
import SwiftUI

class MemoGameViewModel: ObservableObject {
    private static var currentEmoijs = ["🦊","🐧","🦙","🐘","🐫","🐊","🐠","🦑","🦐","🦧","🐄","🐖"]
    
    @Published private(set) var model = createMemoryGame()
    private static let defaultGameDuration = 30
    // MARK: - Konstruktor
    private static func createMemoryGame() -> MemoGameModel<String> {
        
        return MemoGameModel<String>(numberOfCards: currentEmoijs.count,
                                     cardContentFactory: { index in
                                         if (currentEmoijs.indices.contains(index)) {
                                             return currentEmoijs[index]
                                         } else {
                                             return "⁇"
                                         }
                                     },
                                     gameDuration: defaultGameDuration)
    }
    
    var cards: Array<MemoGameModel<String>.Card> {
        return model.cards
    }
    
    // Kolor główny aplikacji
    var gameColor: Color {
        .blue
    }
    
    // MARK: - Intends
    
    func getMainCard() -> MemoGameModel<String>.Card? {
        return model.mainCard
    }
    
    // Wywoływane po onTapGesture w ContentView
    func choose(_ card: MemoGameModel<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
