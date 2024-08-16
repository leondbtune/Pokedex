//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Leon Bethuyne on 16/08/2024.
//

import SwiftUI

let typeColors: [String: Color] = [
    "Normal": Color(.systemGray),
    "Fire": Color(.systemRed),
    "Water": Color(.systemBlue),
    "Electric": Color(.systemYellow),
    "Grass": Color(.systemGreen),
    "Ice": Color(.systemTeal),
    "Fighting": Color(.systemOrange),
    "Poison": Color(.systemPurple),
    "Ground": Color(.brown),
    "Flying": Color(.systemIndigo),
    "Psychic": Color(.systemPink),
    "Bug": Color(.systemGreen),
    "Rock": Color(.systemBrown),
    "Ghost": Color(.systemIndigo),
    "Dragon": Color(.systemPurple),
    "Dark": Color(.systemGray2),
    "Steel": Color(.systemGray3),
    "Fairy": Color(.systemPink)
]

struct PokemonCardView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            } placeholder: {
                ProgressView()
            }

            Text(pokemon.name.capitalized)
                .font(.headline)
                .padding(.top, 5)
                .lineLimit(1)
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)

            HStack {
                ForEach(pokemon.types, id: \.self) { type in
                    Text(type.capitalized)
                        .font(.caption2)
                        .padding(4)
                        .background(typeColors[type, default: Color(.systemGray).opacity(0.1)])
                        .cornerRadius(8)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    PokemonCardView(pokemon: Pokemon(id: 1, name: "bulbasaur", types: ["grass", "poison"], imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
}
