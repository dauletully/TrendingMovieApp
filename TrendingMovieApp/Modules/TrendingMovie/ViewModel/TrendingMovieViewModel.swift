//
//  TrendingMovieViewModel.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 25.04.2025.
//
import UIKit

class TrendingMovieViewModel {
    
    private var movies: [MovieResult]? {
        didSet {
            onMovieFetched?(movies)
        }
    }
    
    public var onMovieFetched: (([MovieResult]?) -> Void)?
    
    public var onMovieSelected: ((String) -> Void)?
    
    
    func didSelectItem(with id: String) {
    
        onMovieSelected?(id)
    }
    
    func fetchMovie() {
        APIManager.shared.fetchTrendingMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .success(let movie):
                    self.movies = movie.movieResults
                    print("Fetched Movies")
                }
            }
        }
    }
    
    func fetchMovieByTitle(with text: String) {
        APIManager.shared.fetchMoviesByTitle(title: text) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .success(let movie):
                    self.movies = movie.movieResults
                    print("Movie fetched")
                }
            }
        }
    }
}
