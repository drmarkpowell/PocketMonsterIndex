//
//  PocketMonsterIndexApp.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/1/24.
//

import SwiftUI
import SwiftData

@main
struct PocketMonsterIndexApp: App {
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pokemon.self, Berry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(appModel)
                 // on macOS, this allows .onOpenURL to act on an existing window and not open another
                 // https://stackoverflow.com/q/66647052
                .handlesExternalEvents(preferring: Set(arrayLiteral: "*"), allowing: ["*"])
                .onOpenURL { url in
                    print("\(url.pathComponents)")
                    guard let index = Int(url.pathComponents.last ?? "") else { return }
                    guard let category = url.host() else { return }
                    appModel.navigateTo(category: String(category), index: index)
                }
        }
        .modelContainer(Self.sharedModelContainer)
    }
}
