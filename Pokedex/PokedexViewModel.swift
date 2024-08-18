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
    private let ownedPokemonKey = "ownedPokemon"
    
    init() {
            loadOwnedPokemon()
        }
    
    @Published var ownedPokemonNames: Set<String> = [] {
        didSet {
            saveOwnedPokemon()
        }
    }

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

    func searchPokemon() {
        if searchText.isEmpty {
                    searchResults = allPokemon
                } else {
                    searchResults = allPokemon.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
    }
    
    func isPokemonOwned(_ pokemon: BasicPokemon) -> Bool {
            ownedPokemonNames.contains(pokemon.name)
        }
        
        func togglePokemonOwnership(_ pokemon: BasicPokemon) {
            if isPokemonOwned(pokemon) {
                ownedPokemonNames.remove(pokemon.name)
            } else {
                ownedPokemonNames.insert(pokemon.name)
            }
        }
    private func saveOwnedPokemon() {
            let ownedPokemonArray = Array(ownedPokemonNames)
            UserDefaults.standard.set(ownedPokemonArray, forKey: ownedPokemonKey)
        }

        private func loadOwnedPokemon() {
            if let ownedPokemonArray = UserDefaults.standard.stringArray(forKey: ownedPokemonKey) {
                ownedPokemonNames = Set(ownedPokemonArray)
            }
        }

}
