//
//  CountdownView.swift
//  CoreProject
//
//  Created by student on 10/12/2024.
//

import SwiftUI

struct CountdownView: View {

    var gameModel: MemoGameModel<String>
    @State private var timeRemaining: Int
    @State private var timer: Timer? = nil
    @State private var timerIsRunning: Bool = false
    
    init(gameModel: MemoGameModel<String>) {
        self.gameModel = gameModel
        _timeRemaining = State(initialValue: gameModel.gameDuration)
    }
    
    var body: some View {
        VStack {
            
            Text("Pozostało: \(timeRemaining) sek.")
                .font(.largeTitle)
                .padding()
                .onAppear(perform: startTimer)
            
            ProgressView( value: Double(gameModel.gameDuration - timeRemaining), total: Double(gameModel.gameDuration))
                
        }
        .onDisappear {
           
            timer?.invalidate()
        }
    }
    
   
    func toggleTimer() {
        if timerIsRunning {
            timer?.invalidate()
        } else {
            startTimer()
        }
        timerIsRunning.toggle()
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()  
                timerIsRunning = false
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        // Inicjalizowanie modelu gry z przykładowymi danymi
        let gameModel = MemoGameModel(numberOfCards: 20, cardContentFactory: { index in "Card \(index)" }, gameDuration: 60)
        CountdownView(gameModel: gameModel)
    }
}




