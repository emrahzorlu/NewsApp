//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import UIKit
import SnapKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(activityIndicator)

        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        activityIndicator.hidesWhenStopped = true
        
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
    }
    
    func configure(with news: News) {
        titleLabel.text = news.title
        activityIndicator.startAnimating()
                
        if let urlToImage = news.urlToImage {
            imageView.setImage(from: urlToImage) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let success):
                    if success {
                        self.activityIndicator.stopAnimating()
                    } else {
                        self.imageView.image = UIImage(named: "defaultImage")
                        self.activityIndicator.stopAnimating()
                    }
                case .failure(let error):
                    print("Image loading failed with error: \(error)")
                    self.imageView.image = UIImage(named: "defaultImage")
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            imageView.image = UIImage(named: "defaultImage")
            activityIndicator.stopAnimating()
        }
    }
}
