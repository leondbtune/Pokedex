//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//
import Foundation

class PokedexViewModel: ObservableObject {
    @Published var allPokemon: [Pokemon] = []
    @Published var ownedPokemon: [OwnedPokemon] = []
    @Published var searchText: String = "" {
            didSet {
                searchPokemon()
            }
        }
    @Published var searchResults: [Pokemon] = []
    
    private let apiService = PokeAPIService()

    func fetchAllPokemon() {
        apiService.fetchPokemonList { [weak self] pokemonList in
                    self?.allPokemon = pokemonList
                    self?.searchResults = pokemonList
                }
    }

    func addPokemonToOwned(pokemon: Pokemon, nickname: String?, dateCaught: Date, level: Int) {
        let newPokemon = OwnedPokemon(id: pokemon.id, pokemon: pokemon, nickname: nickname, dateCaught: dateCaught, level: level)
        ownedPokemon.append(newPokemon)
    }

    func searchPokemon() {
        if searchText.isEmpty {
                    searchResults = allPokemon
                } else {
                    searchResults = allPokemon.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
    }

    func findCounters(for type: String) -> [Pokemon] {
        // TODO
        return []
    }
}
