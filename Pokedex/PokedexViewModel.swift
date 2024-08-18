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
    private let ownedPokemonFilename = "ownedPokemon.json"
    
    init() {
            loadOwnedPokemon()
        }
    
    @Published var ownedPokemon: Set<String> = [] {
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

    private func searchPokemon() {
        if searchText.isEmpty {
            searchResults = allPokemon
        } else if searchText.lowercased() == "owned" {
            searchResults = allPokemon.filter { isPokemonOwned($0) }
        } else if searchText.lowercased() == "!owned" {
            searchResults = allPokemon.filter { !isPokemonOwned($0) }
        } else {
            searchResults = allPokemon.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    func isPokemonOwned(_ pokemon: BasicPokemon) -> Bool {
            ownedPokemon.contains(pokemon.name)
        }
        
        func togglePokemonOwnership(_ pokemon: BasicPokemon) {
            if isPokemonOwned(pokemon) {
                ownedPokemon.remove(pokemon.name)
            } else {
                ownedPokemon.insert(pokemon.name)
            }
        }
    private func saveOwnedPokemon() {
            let fileURL = FileManager.documentDirectory.appendingPathComponent(ownedPokemonFilename)
            do {
                let data = try JSONEncoder().encode(Array(ownedPokemon))
                try data.write(to: fileURL)
            } catch {
                print("Error saving owned Pokémon: \(error)")
            }
        }
    
    private func loadOwnedPokemon() {
            let fileURL = FileManager.documentDirectory.appendingPathComponent(ownedPokemonFilename)
            do {
                let data = try Data(contentsOf: fileURL)
                let ownedPokemonArray = try JSONDecoder().decode([String].self, from: data)
                ownedPokemon = Set(ownedPokemonArray)
            } catch {
                print("Error loading owned Pokémon: \(error)")
            }
        }
    
    
}
extension FileManager {
    static var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
