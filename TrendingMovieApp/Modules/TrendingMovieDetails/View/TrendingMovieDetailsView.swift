//
//  TrendingMovieDetailsView.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 26.04.2025.
//
import UIKit
import SnapKit

class TrendingMovieDetailsView: UIViewController {
    private let viewModel = TrendingMovieDetailsViewModel()
    
    //MARK: - Building UI elements
    //Scrolling
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    //Title
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var tagLine: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        return label
    }()
    
    //Card
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.textColor = .black
        
        return label
    }()
    
    private let runTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkText
        
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private let directorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private let countriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    
    private let languagesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.setTitle("▶️ Watch Trailer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.systemRed
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
        setupConstraints()
        setupBinding()
        
        DispatchQueue.main.async {
            self.viewModel.fetchMovieDetails(id: 1)
        }
    }
    private func setupBinding() {
        viewModel.onMovieDetailsFetched = { [weak self] movieDetails in
            self?.configure(with: movieDetails)
        }
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagLine)
        contentView.addSubview(cardView)
        
        [ratingLabel, yearLabel, runTimeLabel, descriptionLabel, genresLabel, starsLabel, directorsLabel, countriesLabel, languagesLabel, trailerButton].forEach {
            cardView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {  make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview().inset(20)
        }
        
        tagLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(tagLine.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(28)
            $0.width.greaterThanOrEqualTo(60)
        }
        
        yearLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel)
            $0.left.equalTo(ratingLabel.snp.right).offset(16)
        }
        
        runTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingLabel)
            $0.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        starsLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        directorsLabel.snp.makeConstraints {
            $0.top.equalTo(starsLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        countriesLabel.snp.makeConstraints {
            $0.top.equalTo(directorsLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        languagesLabel.snp.makeConstraints {
            $0.top.equalTo(countriesLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        trailerButton.snp.makeConstraints {
            $0.top.equalTo(languagesLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(40)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    func configure(with model: MovieDetails?) {
            titleLabel.text = model?.title
            tagLine.text = model?.tagline
            ratingLabel.text = "⭐️ \(model?.imdbRating)"
            yearLabel.text = "Year: \(model?.year)"
            runTimeLabel.text = "⏱ \(model?.runtime) min"
            descriptionLabel.text = model?.description
            genresLabel.text = "Genres: \(model?.genres.joined(separator: ", "))"
            starsLabel.text = "Stars: \(model?.stars.joined(separator: ", "))"
            directorsLabel.text = "Directors: \(model?.directors.joined(separator: ", "))"
            countriesLabel.text = "Countries: \(model?.countries.joined(separator: ", "))"
            languagesLabel.text = "Languages: \(model?.language.joined(separator: ", "))"
        }
}
