//
//  TrendingMovieDetailsViewModel.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 26.04.2025.
//
import UIKit

class TrendingMovieDetailsViewModel {
    private var movieDetails: MovieDetails? {
        didSet {
            onMovieDetailsFetched?(movieDetails)
        }
    }
    var onLoadingStateChange: ((Bool) -> Void)?
    public var onMovieDetailsFetched: ((MovieDetails?) -> Void)?
    public var onErrorFetched: (() -> Void)?
    
    func fetchMovieDetails(id: String) {
        onLoadingStateChange?(true)
        
        APIManager.shared.fetchMovieDetails(id: id) { result in
            DispatchQueue.main.async {
                self.onLoadingStateChange?(false)
                switch result {
                    case .success(let movieDetails):
                    self.movieDetails = movieDetails
                case .failure(let error):
                    self.onErrorFetched?()
                }
            }
        }
    }
}
