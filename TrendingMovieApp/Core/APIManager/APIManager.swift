//
//  APIManager.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 25.04.2025.
//

import UIKit

class APIManager {
    static let shared = APIManager()
    init (){}
    private let baseURL = "https://movies-tv-shows-database.p.rapidapi.com"
    private let apiKey = "36b5dbb4ffmsh584fbb12d204012p1f48b9jsn6d4cce65e5cf"
    private let apiHost = "movies-tv-shows-database.p.rapidapi.com"
    
    func fetchTrendingMovies(completion: @escaping (Result<Movie, Error>) -> Void) {
        let apiType = "get-trending-movies"
        guard let url = URL(string: "\(baseURL)/?type=\(apiType)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiType, forHTTPHeaderField: "Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Empty Data", code: 0, userInfo: nil)))
                print("No data")
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let apiType = "get-movie-details"
        guard let url = URL(string: "\(baseURL)/?movieid=\(id)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiType, forHTTPHeaderField: "Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Empty Data", code: 1001, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
