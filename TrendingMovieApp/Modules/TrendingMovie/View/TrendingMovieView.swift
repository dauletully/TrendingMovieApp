//
//  TrendingMovieView.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 25.04.2025.
//
import UIKit
import SnapKit

class TrendingMovieView: UIViewController {
    
    private var viewModel: TrendingMovieViewModel!
    private var movieCatalog: [MovieResult]?
    
    init(viewModel: TrendingMovieViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var movieCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 343, height: 100)
        layout.sectionInsetReference = .fromSafeArea
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionMovieCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupBinding()
        
        DispatchQueue.main.async {
            self.viewModel.fetchMovie()
        }
    }
    
    private func setupBinding() {
        viewModel.onMovieFetched = { [weak self] movieCatalog in
            self?.movieCatalog = movieCatalog
            self?.movieCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(movieCollectionView)
    }
    
    private func setupConstraints() {
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TrendingMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCatalog?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieItem = movieCatalog?[indexPath.row] else {fatalError("Error: No data available")}
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? CollectionMovieCell else {return CollectionMovieCell()}
        cell.configure(with: movieItem)
        
        return cell
    }
}

