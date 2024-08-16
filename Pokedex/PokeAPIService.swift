//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import Foundation

let mockPokemonList: [Pokemon] = [
    Pokemon(id: 1, name: "bulbasaur", types: ["grass", "poison"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
    Pokemon(id: 4, name: "charmander", types: ["fire"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"),
    Pokemon(id: 7, name: "squirtle", types: ["water"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"),
    Pokemon(id: 25, name: "pikachu", types: ["electric"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
]

let mockPokemonDetails: Pokemon = Pokemon(
    id: 1,
    name: "bulbasaur",
    types: ["grass", "poison"],
    imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    // TODO
)

class PokeAPIService {
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(mockPokemonList)
                }
        // TODO
    }
    
    func fetchPokemonDetails(for id: Int, completion: @escaping (Pokemon) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completion(mockPokemonDetails)
                }
        // TODO
    }
    
    func fetchTypeCounters(for type: String, completion: @escaping ([Pokemon]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let counters = mockPokemonList.filter { $0.types.contains(type) }
                    completion(counters)
                }
        // TODO
    }
}
