//
//  HomeScreen.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/22/24.
//

import SwiftData
import SwiftUI

struct TabsView: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.modelContext) private var modelContext
    @Query private var pokemon: [Pokemon]
    @Query private var berries: [Berry]

    var body: some View {
        @Bindable var appModel = appModel
        TabView(selection: $appModel.selectedTabName) {
            PokedexScreen()
                .tabItem {
                    Text(appModel.pokedexTab.name.rawValue)
                }
                .tag(appModel.pokedexTab.name)

            BerriesScreen()
                .tabItem {
                    Text(appModel.berriesTab.name.rawValue)
                }
                .tag(appModel.berriesTab.name)
        }
        .task {
            if pokemon.isEmpty {
                await PokeAPI.shared.loadCSV(container: PocketMonsterIndexApp.sharedModelContainer)
            }
            if berries.isEmpty {
                await PokeAPI.shared.fetchBerryResults(container: PocketMonsterIndexApp.sharedModelContainer)
            }
        }
    }
}

#Preview {
    TabsView()
        .environment(AppModel())
}
