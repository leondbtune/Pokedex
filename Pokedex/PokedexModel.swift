//
//  PokedexModel.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let types: [String]
    let imageURL: String
}

struct OwnedPokemon: Identifiable {
    let id: Int
    let pokemon: Pokemon
    let nickname: String?
    let dateCaught: Date
    let level: Int
}
