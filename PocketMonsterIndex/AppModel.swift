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
    
    func navigateTo(category: String, index: Int) {
        if category == berriesTab.name.rawValue {
            berriesTab.path = NavigationPath([index])
            selectedTabName = .berries
        } else if category == pokedexTab.name.rawValue {
            pokedexTab.path = NavigationPath([index])
            selectedTabName = .pokedex
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
