//
//  CoreProjectApp.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import SwiftUI

@main
struct CoreProjectApp: App {
    @StateObject var game = MemoGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
