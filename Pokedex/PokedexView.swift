//
//  PokedexView.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import SwiftUI

struct PokedexView: View {
    @ObservedObject var viewModel: PokedexViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.searchResults) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    PokemonCardView(pokemon: pokemon)
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationBarTitle("Pokedex")
                    .searchable(text: $viewModel.searchText, prompt: "Search Pokémon")
                }
    }
}

struct PokemonDetailView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            // TODO
            Button("Add to Owned Pokémon") {
                // TODO
            }
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}

struct OwnedPokemonView: View {
    @ObservedObject var viewModel: PokedexViewModel

    var body: some View {
        List(viewModel.ownedPokemon) { ownedPokemon in
            NavigationLink(destination: PokemonDetailView(pokemon: ownedPokemon.pokemon)) {
                HStack {
                    // TODO
                }
            }
        }
        .navigationBarTitle("My Pokémon")
    }
}

#Preview {
    let viewModel = PokedexViewModel()
    viewModel.searchResults = [
        Pokemon(id: 1, name: "Bulbasaur", types: ["Grass", "Poison"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
        Pokemon(id: 4, name: "Charmander", types: ["Fire"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
        Pokemon(id: 7, name: "Squirtle", types: ["Water"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
        Pokemon(id: 25, name: "Pikachu", types: ["Electric"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
        Pokemon(id: 39, name: "Jigglypuff", types: ["Normal", "Fairy"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png"),
        Pokemon(id: 52, name: "Meowth", types: ["Normal"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/52.png"),
        Pokemon(id: 150, name: "Mewtwo", types: ["Psychic"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png"),
        Pokemon(id: 143, name: "Snorlax", types: ["Normal"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png"),
        Pokemon(id: 94, name: "Gengar", types: ["Ghost", "Poison"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png"),
        Pokemon(id: 131, name: "Lapras", types: ["Water", "Ice"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/131.png"),
        Pokemon(id: 149, name: "Dragonite", types: ["Dragon", "Flying"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/149.png"),
        Pokemon(id: 248, name: "Tyranitar", types: ["Rock", "Dark"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/248.png"),
        Pokemon(id: 350, name: "Milotic", types: ["Water"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/350.png"),
        Pokemon(id: 359, name: "Absol", types: ["Dark"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/359.png"),
        Pokemon(id: 445, name: "Garchomp", types: ["Dragon", "Ground"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/445.png")
    ]
    return PokedexView(viewModel: viewModel)
}
