//
//  BerriesScreen.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/22/24.
//

import NukeUI
import SwiftData
import SwiftUI

struct BerriesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppModel.self) var appModel
    @Query(sort: \Berry.id) private var berries: [Berry]
    let cellSize: CGFloat = 128

    var body: some View {
        @Bindable var appModel = appModel
        NavigationStack(path: $appModel.berriesTab.path) {
            GeometryReader { geom in
                ScrollView {
                    LazyVGrid(columns: gridItems(geom.size.width)) {
                        ForEach(berries) { berry in
                            Button {
                                appModel.berriesTab.path.append(berry.id)
                            } label: {
                                VStack {
                                    LazyImage(url: berry.defaultFrontImage)
                                        .padding()
                                    Text(berry.name.capitalized)
                                        .font(.headline)
                                        .overlay {
                                            Text("\(berry.id)")
                                                .font(.caption2)
                                                .offset(x: 0, y: -14)
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text(appModel.berriesTab.name.rawValue))
            .navigationDestination(for: Int.self) { id in
                BerryScreen(id: id)
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
    BerriesScreen()
        .environment(AppModel())
}
