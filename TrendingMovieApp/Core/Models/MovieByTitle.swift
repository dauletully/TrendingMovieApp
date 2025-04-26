//
//  MovieByTitle.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 26.04.2025.
//

import Foundation

// MARK: - Movie by title
struct MovieByTitle: Codable {
    let movieResults: [MovieResultS]
    let searchResults: Int
    let status, statusMessage: String

    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case searchResults = "search_results"
        case status
        case statusMessage = "status_message"
    }
}

struct MovieResultS: Codable {
    let title: String
    let year: Int
    let imdbID: String

    enum CodingKeys: String, CodingKey {
        case title, year
        case imdbID = "imdb_id"
    }
}

extension MovieResultS {
    var yearString: String {
        return "\(year)"
    }
}
