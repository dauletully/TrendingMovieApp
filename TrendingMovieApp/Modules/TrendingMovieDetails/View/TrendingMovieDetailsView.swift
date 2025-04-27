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
    var id: String?
    
    
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
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        
        return indicator
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
            self.viewModel.fetchMovieDetails(id: self.id!)
        }
    }
    private func setupBinding() {
        viewModel.onMovieDetailsFetched = { [weak self] movieDetails in
            self?.configure(with: movieDetails)
        }
        viewModel.onErrorFetched = { [weak self] in
            self?.showEmptyAlert()
        }
        viewModel.onLoadingStateChange = { [weak self] isLoading in
                    if isLoading {
                        self?.loadingIndicator.startAnimating()
                    } else {
                        self?.loadingIndicator.stopAnimating()
                    }
                }
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        view.addSubview(loadingIndicator)
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
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalTo(contentView)
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
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(28)
            make.width.greaterThanOrEqualTo(60)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.left.equalTo(ratingLabel.snp.right).offset(16)
        }
        
        runTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingLabel)
            make.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
        }
        
        starsLabel.snp.makeConstraints { make in
            make.top.equalTo(genresLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        directorsLabel.snp.makeConstraints { make in
            make.top.equalTo(starsLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        countriesLabel.snp.makeConstraints { make in
            make.top.equalTo(directorsLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        languagesLabel.snp.makeConstraints { make in
            make.top.equalTo(countriesLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        trailerButton.snp.makeConstraints { make in
            make.top.equalTo(languagesLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func configure(with model: MovieDetails?) {
        titleLabel.text = model?.title
            tagLine.text = model?.tagline
        ratingLabel.text = "⭐️ \(model?.imdbRating ?? "not available")"
            yearLabel.text = "Year: \(model?.year ?? "not available")"
            runTimeLabel.text = "⏱ \(model?.runtime ?? 0 ) min"
            descriptionLabel.text = model?.description
        genresLabel.text = "Genres: \(model?.genres.joined(separator: ", ") ?? "not available")"
        starsLabel.text = "Stars: \(model?.stars.joined(separator: ", ") ?? "not available")"
        directorsLabel.text = "Directors: \(model?.directors.joined(separator: ", ") ?? "not available")"
        countriesLabel.text = "Countries: \(model?.countries.joined(separator: ", ") ?? "not available")"
        languagesLabel.text = "Languages: \(model?.language.joined(separator: ", ") ?? "not available")"
        }
    
    private func showEmptyAlert() {
        let alert = UIAlertController(title: "Нет данных", message: "Детали фильма отсутствуют.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
