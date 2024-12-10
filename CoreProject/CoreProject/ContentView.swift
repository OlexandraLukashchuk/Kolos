//
//  ContentView.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : MemoGameViewModel
    
    var body: some View {
        VStack(){
            Text("Memory Game").font(.largeTitle)
            CountdownView(gameModel: viewModel.model)
            mainCard
            cardDisplay
                .foregroundStyle(viewModel.gameColor)
            Spacer()
            HStack {
                shuffleButton
            }
        }
    }
    
    
    var shuffleButton: some View {
        Button("SHUFFLE") {
            withAnimation {
                viewModel.shuffle()
            }
        }
        .foregroundStyle(viewModel.gameColor)
        .font(.system(size: Constants.FontSize.medium))
    }
    
    var mainCard: some View {
        return
            CardView(card: viewModel.getMainCard()!)
            .frame(height: Constants.mainCardHeight)
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
                .foregroundStyle(viewModel.gameColor)
    }
    
    var cardDisplay: some View {
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio) { card in
            CardView(card: card)
                .aspectRatio(Constants.aspectRatio,  contentMode: .fit)
                .padding(Constants.insets)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}


#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
