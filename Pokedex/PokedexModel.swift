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
    let height: Int?
    let order: Int?
    let weight: Int?
    let abilities: [Ability]?
    let forms: [Species]?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let species: Species
    let sprites: Sprites
    let stats: [Stat]?
    let types: [TypeElement]
    let pastTypes: [PastType]?
    let cries: Cries?
}

struct Ability: Codable {
    let slot: Int?
    let ability: Species?
}

struct Species: Codable {
    let name: String
    let url: String?
}

struct HeldItem: Codable {
    let item: Species?
    let versionDetails: [VersionDetail]?
}

struct VersionDetail: Codable {
    let rarity: Int?
    let version: Species?
}

struct Move: Codable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int?
    let versionGroup: Species?
    let moveLearnMethod: Species?
}

struct PastType: Codable {
    let generation: Species
    let types: [TypeElement]?
}

struct TypeElement: Codable {
    let slot: Int?
    let type: Species
}

struct Cries: Codable {
    let latest: String?
    let legacy: String?
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

struct Stat: Codable {
    let baseStat: Int?
    let effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

enum PokeAPIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
