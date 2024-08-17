//
//  PokedexView.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import SwiftUI

struct PokedexView: View {
    
    @ObservedObject var viewModel: PokedexViewModel
    
    private let gridItemLayout = [GridItem(.adaptive(minimum: 100))]
    
    

    var body: some View {
        NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.searchResults) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon, viewModel: viewModel)) {
                                    PokemonCardView(pokemon: pokemon, viewModel: viewModel)
                                }
                            }
                        }
                        .padding()
                        
                    }
                    .navigationBarTitle("Pokedex")
                    .searchable(text: $viewModel.searchText, prompt: "Search Pokémon")
                    .refreshable {
                        viewModel.fetchAllPokemon()
                    }
                }
        .onAppear{
            viewModel.fetchAllPokemon()
        }
    }
}

struct PokemonDetailView: View {
    let pokemon: BasicPokemon
    
    @ObservedObject var viewModel: PokedexViewModel

    var body: some View {
        VStack {
            Button("Add to Owned") {
                // TODO
            }
            PokemonCardView(pokemon: pokemon, viewModel: viewModel)
            
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}
