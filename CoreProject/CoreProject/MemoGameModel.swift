//
//  MemoGameModel.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import Foundation

struct MemoGameModel<CardContent> where CardContent : Equatable {
    private(set) var cards: Array<Card>
    private(set) var mainCard: Card? = nil
    var gameDuration: Int
    private(set) var gameStarted = false
    private(set) var gameEnded = false
    var score = 0
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContent, gameDuration: Int) {
        self.gameDuration = gameDuration
        cards = []
        let mainCardNumber = Int.random(in: 0..<numberOfCards)
        for index in 0..<numberOfCards {
            let content: CardContent = cardContentFactory(index)
            cards.append(Card(content: content, id: "\(index)a"))
            if mainCardNumber == index {
                // Utwórz kartę główną
                self.mainCard = Card(content: content, id: "\(index)b")
                self.mainCard?.isFaceUp = true
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if gameEnded { return }
        if let chosenIndex = index(of: card) {
            cards[chosenIndex].isFaceUp.toggle()
            
            if getCardNumber(mainCard!) == getCardNumber(cards[chosenIndex]) {
                mainCard?.isMached = true
                cards[chosenIndex].isMached = true
                changeVisible()
                score += 2
            } else {
                if let indexOfFacedUpCard = indexOfFacedUpCard(card) {
                    cards[indexOfFacedUpCard].isFaceUp = false
                }
            }
        }
    }
    
    mutating func startGame() {
        gameStarted = true
        gameEnded = false
        score = 0
        mainCard?.isVisible = true
        mainCard?.isFaceUp = true
        for index in cards.indices {
            if cards[index].id != mainCard?.id {
                cards[index].isVisible = false
                cards[index].isFaceUp = false
                cards[index].isMached = false
            }
        }
    }
    
    mutating func shuffle() {
         cards.shuffle()
    }
    
    // Zwraca numer karty bez litery na końcu
    private func getCardNumber(_ card: Card) -> String {
        let id = card.id
        return String(id[..<id.index(before: id.endIndex)])
    }
    
    private mutating func changeVisible() {
        for index in cards.indices {
            if !cards[index].isMached {
                cards[index].isVisible = false
            }
        }
    }
    
    // Zwraca indeks karty, która jest odwrócona, a która nie została
    // aktualnie wybrana (poprzednio odsłonięta)
    private func indexOfFacedUpCard(_ card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].isFaceUp {
                if cards[index].id != card.id {
                    return index
                }
            }
        }
        return nil
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMached = false
        var isVisible = true
        let content: CardContent
        var id: String
    }
}


