//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//
import Foundation

class PokedexViewModel: ObservableObject {
    @Published var allPokemon: [BasicPokemon] = []
    @Published var searchText: String = "" {
            didSet {
                searchPokemon()
            }
        }
    @Published var searchResults: [BasicPokemon] = []
    private var detailedPokemonCache: [String: Pokemon] = [:]
    
    private let apiService = PokeAPIService()

    func fetchAllPokemon() {
        apiService.fetchPokemonList { [weak self] pokemons in
                    self?.allPokemon = pokemons
                    self?.searchResults = pokemons
                }
        
    }
    
    func fetchPokemonDetails(for basicPokemon: BasicPokemon, completion: @escaping (Pokemon) -> Void) {
        if let cachedPokemon = detailedPokemonCache[basicPokemon.name] {
                    completion(cachedPokemon)
                } else {
                    apiService.fetchPokemonDetails(url: basicPokemon.url) { pokemonDetails in
                        self.detailedPokemonCache[pokemonDetails.name] = pokemonDetails
                        completion(pokemonDetails)
                    }
                }
    }

    func addPokemonToOwned(pokemon: Pokemon, nickname: String?, dateCaught: Date, level: Int) {
        // TODO
    }

    func searchPokemon() {
        if searchText.isEmpty {
                    searchResults = allPokemon
                } else {
                    searchResults = allPokemon.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
    }

}
