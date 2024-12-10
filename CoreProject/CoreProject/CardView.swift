//
//  CardView.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import SwiftUI

struct CardView: View {
    let card: MemoGameModel<String>.Card
    
    var body: some View {
        let rectangle: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        ZStack{
            Group{
                rectangle.fill(.white)
                rectangle.strokeBorder(style: StrokeStyle(lineWidth: Constants.lindeWidth))
                Text(card.content)
                    .font(.system(size: Constants.FontSize.large))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            .opacity(card.isFaceUp ? 1 : 0)
            rectangle.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isVisible ? 1 : 0)
    }
}
