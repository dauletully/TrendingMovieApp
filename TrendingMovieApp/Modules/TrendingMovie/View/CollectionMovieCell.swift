//
//  CollectionMovieCell.swift
//  TrendingMovieApp
//
//  Created by Nurlybaqyt Begaly on 25.04.2025.
//

import UIKit
import SnapKit

class CollectionMovieCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 2
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIfNeeded()
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(yearLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
    }
    
    public func configure(with movie: MovieResult) {
        self.titleLabel.text = movie.title
        self.yearLabel.text = movie.year
    }
}
