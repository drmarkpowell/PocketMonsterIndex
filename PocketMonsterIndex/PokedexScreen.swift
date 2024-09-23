//
//  ContentView.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/1/24.
//

import NukeUI
import SwiftUI
import SwiftData

struct PokedexScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppModel.self) var appModel
    @Query(sort: \Pokemon.id) private var pokemon: [Pokemon]
    let cellSize: CGFloat = 128

    var body: some View {
        @Bindable var appModel = appModel
        
        NavigationStack(path: $appModel.pokedexTab.path) {
            GeometryReader { geom in
                ScrollView {
                    LazyVGrid(columns: gridItems(geom.size.width)) {
                        ForEach(pokemon) { pokemon in
                            Button {
                                appModel.pokedexTab.path.append(pokemon.id)
                            } label: {
                                VStack {
                                    LazyImage(url: pokemon.defaultFrontImage)
                                    Text(pokemon.name.capitalized)
                                        .font(.headline)
                                        .overlay {
                                            Text("\(pokemon.id)")
                                                .font(.caption2)
                                                .offset(x: 0, y: -14)
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text(appModel.pokedexTab.name.rawValue))
            .navigationDestination(for: Int.self) { id in
                PokemonScreen(id: id)
            }
        }
    }

    func gridItems(_ width: CGFloat) -> [GridItem] {
        let numCols = Int(floor(width / cellSize))
        var gridItems = [GridItem]()
        for _ in 0..<numCols {
            gridItems.append(GridItem(.fixed(cellSize)))
        }
        return gridItems
    }
}

#Preview {
    PokedexScreen()
        .environment(AppModel())
}
