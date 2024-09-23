//
//  PokemonScreen.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/22/24.
//

import NukeUI
import SwiftData
import SwiftUI

struct PokemonScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppModel.self) var appModel
    @Query(sort: \Pokemon.id) private var pokemon: [Pokemon]
    let id: Int
    var body: some View {
        if let pokemon = pokemon.first(where: { id == $0.id }) {
            VStack {
                LazyImage(url: pokemon.defaultFrontImage) { state in
                    if let image = state.image {
                        image.resizable().aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 256, maxHeight: 256)
                    }
                }
            }.navigationTitle(Text(pokemon.name))
        } else {
            ContentUnavailableView("Unable to find Pokemon #\(id)", systemImage: "questionmark.circle")
        }
    }
}

#Preview {
    PokemonScreen(id: 1)
        .environment(AppModel())
}
