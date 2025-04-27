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
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search movies..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.clearButtonMode = .whileEditing
        textField.setLeftIcon(UIImage(systemName: "magnifyingglass")!)
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .black
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var movieCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 343, height: 80)
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
        viewModel.onMovieSelected = { [weak self] movieID in
            guard let self = self else { return }
            let detailViewController = TrendingMovieDetailsView()
            detailViewController.id = movieID
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(movieCollectionView)
    }
    
    private func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(25)
        }
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TrendingMovieView: UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCatalog?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieItem = movieCatalog?[indexPath.row] else {fatalError("Error: No data available")}
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? CollectionMovieCell else {return CollectionMovieCell()}
        cell.configure(with: movieItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(with: movieCatalog?[indexPath.row].imdbID ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        guard let searchText = textField.text, !searchText.isEmpty else { return false }
        
        viewModel.fetchMovieByTitle(with: searchText)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.isEmpty {
            viewModel.fetchMovie() // Показать основной список
        }
        return true
    }
    
}

