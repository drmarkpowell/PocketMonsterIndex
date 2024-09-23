//
//  BerryScreen.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/22/24.
//

import NukeUI
import SwiftData
import SwiftUI

struct BerryScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppModel.self) var appModel
    @Query(sort: \Berry.id) private var berries: [Berry]
    let id: Int
    var body: some View {
        if let berry = berries.first(where: { id == $0.id }) {
            VStack {
                LazyImage(url: berry.defaultFrontImage) { state in
                    if let image = state.image {
                        image.resizable().aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 128, maxHeight: 128)
                    }
                }
            }
            .navigationTitle(Text(berry.name.capitalized))
        } else {
            ContentUnavailableView("Unable to find Berry #\(id)", systemImage: "questionmark.circle")
        }
    }
}

#Preview {
    BerryScreen(id: 1)
        .modelContainer(for: Berry.self, inMemory: true)
        .environment(AppModel())
}
