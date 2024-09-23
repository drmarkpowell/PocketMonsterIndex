//
//  PokeAPI.swift
//  PocketMonsterIndex
//
//  Created by Mark Powell on 9/21/24.
//

import CodableCSV
import Foundation
import os.log
import SwiftData

actor PokeAPI {
    let logger = Logger(subsystem: "PMI.PokeAPI", category: "main")
    static let shared = PokeAPI()

    private init() {}

    func fetchPokemonResults() async {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=2000")!
        logger.info("Fetching Pokemon results from \(url)")
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let results = try JSONDecoder().decode(PokemonResults.self, from: data)
            for (index, result) in results.results.enumerated() {
                _ = Pokemon(id: index + 1, name: result.name)
            }
        } catch let error {
            logger.error("Error fetching Pokemon: \(error)")
        }
    }

    func fetchBerryResults(container: ModelContainer) async {
        let modelContext = ModelContext(container)
        let url = URL(string: "https://pokeapi.co/api/v2/berry?offset=0&limit=100")!
        logger.info("Fetching Berry results from \(url)")
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let results = try JSONDecoder().decode(BerryResults.self, from: data)
            for (index, result) in results.results.enumerated() {
                modelContext.insert(Berry(id: index + 1, name: result.name))
            }
            try modelContext.save()
        } catch let error {
            logger.error("Error fetching Berries: \(error)")
        }
    }


    func loadCSV(container: ModelContainer) {
        let modelContext = ModelContext(container)
        guard let fileURL = Bundle.main.url(forResource: "pokemonids", withExtension: "csv") else {
            fatalError("Couldn't find pokemonids CSV file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let csv = try CSVReader.decode(input: data)
            csv.rows.forEach { row in
                guard let id = Int(row[0]) else {
                    return
                }
                let name = row[1]
                modelContext.insert(Pokemon(id: id, name: name))
            }
            try modelContext.save()
        } catch let error {
            logger.error("Error loading CSV: \(error)")
        }
    }
}

// MARK: Codable PokeAPI result types

struct PokemonResults: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonResult]
}

struct BerryResults: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonResult]
}


struct PokemonResult: Codable {
    var name: String
    var url: String
}
