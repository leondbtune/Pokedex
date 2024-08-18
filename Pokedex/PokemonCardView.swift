//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import SwiftUI

let typeColors: [String: Color] = [
    "normal": Color(.systemGray),
    "fire": Color(.systemRed),
    "water": Color(.systemBlue),
    "electric": Color(.systemYellow),
    "grass": Color(.systemGreen),
    "ice": Color(.systemTeal),
    "fighting": Color(.systemOrange),
    "poison": Color(.systemPurple),
    "ground": Color(.brown),
    "flying": Color(.systemIndigo),
    "psychic": Color(.systemPink),
    "bug": Color(.systemGreen),
    "rock": Color(.systemBrown),
    "ghost": Color(.systemIndigo),
    "dragon": Color(.systemPurple),
    "dark": Color(.systemGray2),
    "steel": Color(.systemGray3),
    "fairy": Color(.systemPink)
]

struct PokemonCardView: View {
    let pokemon: BasicPokemon
    @State private var pokemonDetails: Pokemon?
    @ObservedObject var viewModel: PokedexViewModel
    
    private let ownedCardColor = LinearGradient(gradient: Gradient(colors: [Color.white, Color.green]), startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack(alignment: .leading) {
            if let details = pokemonDetails, let imageUrl = pokemonDetails?.sprites.frontDefault {
                if let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                    } placeholder: {
                        ProgressView()
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    }
                }

                Text(details.name.capitalized)
                    .font(.headline)
                    .padding(.top, 5)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)

                HStack {
                    ForEach(details.types, id: \.type.name) { typeElement in
                        Text(typeElement.type.name.capitalized)
                            .font(.caption2)
                            .padding(4)
                            .background(typeColors[typeElement.type.name, default: Color(.systemGray).opacity(0.1)])
                            .cornerRadius(8)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .foregroundColor(.black)
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        fetchDetails()
                    }
            }
        }
        .padding()
        .background(viewModel.isPokemonOwned(pokemon) ? ownedCardColor : LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
    
    private func fetchDetails() {
        viewModel.fetchPokemonDetails(for: pokemon) { details in
            pokemonDetails = details
        }
    }
}
