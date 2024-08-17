//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject var viewModel = PokedexViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokedexView(viewModel: viewModel)
        }
    }
}
