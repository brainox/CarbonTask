//
//  Movie.swift
//  CarbonTask
//
//  Created by Decagon on 17/02/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sessionResponse = try? newJSONDecoder().decode(SessionResponse.self, from: jsonData)

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let search: [Search]
    let totalResults: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
    
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case game = "game"
    case movie = "movie"
    case series = "series"
}

