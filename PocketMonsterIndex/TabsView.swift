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
    @State private var customization = TabViewCustomization()
    @Query private var pokemon: [Pokemon]
    @Query private var berries: [Berry]

    var body: some View {
        @Bindable var appModel = appModel
        TabView(selection: $appModel.selectedTabName) {
            Tab(
                TabName.pokedex.title,
                systemImage: "square.grid.3x3",
                value: TabName.pokedex
            ) {
                PokedexScreen()
            }
            .customizationID(TabName.pokedex.rawValue)

            Tab(
                TabName.berries.title,
                systemImage: "carrot.fill",
                value: TabName.berries
            ) {
                BerriesScreen()
            }
            .customizationID(TabName.berries.rawValue)
        }
        .tabViewCustomization($customization)
        .tabViewStyle(.sidebarAdaptable)
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
