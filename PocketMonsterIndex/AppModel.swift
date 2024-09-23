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
    var pokedexTab = Tab(name: .pokedex)
    var berriesTab = Tab(name: .berries)
}

@Observable
class Tab {
    let name: TabName
    var path = NavigationPath()
    init(name: TabName) {
        self.name = name
    }
}

enum TabName: String, CaseIterable {
    case pokedex
    case berries
}
