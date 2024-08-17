//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import Foundation

class PokeAPIService {
    private let baseURL = "https://pokeapi.co/api/v2"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func fetchPokemonList(completion: @escaping ([BasicPokemon]) -> ()) {
        let endpoint = "\(baseURL)/pokemon?limit=151"
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        session.dataTask(with: url) {
            (data, response, _) in guard let data = data else { return }
            
            let list = try! self.decoder.decode(PokemonListResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion(list.results)
            }
        }.resume()
        
    }
    
    func fetchPokemonDetails(url: String, completion: @escaping (Pokemon) -> Void) {
        guard let urlurl = URL(string: url) else {
            return
        }
        
        session.dataTask(with: urlurl) {
            (data, _, _) in guard let data = data else {
                print("no data")
                return
            }
            
            let pokemonDetails = try! self.decoder.decode(Pokemon.self, from: data)

            DispatchQueue.main.async {
                completion(pokemonDetails)
            }
        }.resume()
        
    }
}
