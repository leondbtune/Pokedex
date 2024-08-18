//
//  PokedexModel.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import Foundation

struct BasicPokemon: Identifiable, Codable {
    let id = UUID()
    let name: String
    let url: String
}

struct PokemonListResponse: Codable {
    let results: [BasicPokemon]
}

struct Pokemon: Codable {
    let id: Int?
    let name: String
    let forms: [Species]?
    let species: Species
    let sprites: Sprites
    let types: [TypeElement]
}


struct Species: Codable {
    let name: String
    let url: String?
}


struct TypeElement: Codable {
    let slot: Int?
    let type: Species
}

struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    let other: OtherSprites?
    
    private enum CodingKeys: String, CodingKey {
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
            case other
        }
}

struct OtherSprites: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?
    let showdown: Showdown?
}

struct DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?
}

struct Home: Codable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

struct OfficialArtwork: Codable {
    let frontDefault: String?
    let frontShiny: String?
}

struct Showdown: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}
