//
//  AppModel.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/21/24.
//

import SwiftUI

@Observable
class AppModel {
    var selectedTabName = TabName.pokedex
    var pokedexTab = TabModel(name: .pokedex)
    var berriesTab = TabModel(name: .berries)

    // On macOS, setting selected tab and nav path together did not create the new detail view reliably
    // Creating a second Task to set the path after first setting the selected tab works better.
    func navigateTo(category: String, index: Int) {
        if category == berriesTab.name.rawValue {
            selectedTabName = .berries
            Task { @MainActor in
                berriesTab.path = NavigationPath()
                berriesTab.path.append(index)
            }
        } else if category == pokedexTab.name.rawValue {
            selectedTabName = .pokedex
            Task { @MainActor in
                pokedexTab.path = NavigationPath()
                pokedexTab.path.append(index)
            }
        }
    }
}

@Observable
class TabModel {
    let name: TabName
    var path = NavigationPath()
    init(name: TabName) {
        self.name = name
    }
}

enum TabName: String, CaseIterable {
    case pokedex
    case berries
    var title: String { rawValue.capitalized }
}
