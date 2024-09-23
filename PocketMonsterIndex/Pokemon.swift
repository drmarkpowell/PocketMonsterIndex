//
//  Pokemon.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/22/24.
//

import Foundation
import SwiftData

@Model
final class Pokemon: Identifiable {
    var id: Int
    var name: String
    var defaultFrontImage: URL {
        return URL(
            string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        )!
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

@Model
final class Berry: Identifiable {
    var id: Int
    var name: String
    var defaultFrontImage: URL {
        return URL(
            string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(name)-berry.png"
        )!
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
