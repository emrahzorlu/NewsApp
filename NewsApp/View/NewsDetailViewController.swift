//
// NewsDetailViewController.swift
// NewsApp
//
// Created by Emrah Zorlu on 4.07.2024.

import UIKit
import SnapKit
import SafariServices

protocol DetailDisplayLayer: BaseControllerProtocol {
    func setupViews()
    func configure(with viewModel: DetailBusinessLayer)
}

class NewsDetailViewController: UIViewController, DetailDisplayLayer {
    
    var viewModel: DetailBusinessLayer
    
    private let imageView = UIImageView()
    private let sourceLabel = UILabel()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let authorNameLabel = UILabel()
    
    private lazy var openInBrowserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open in Browser", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openInBrowser), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: DetailBusinessLayer) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.viewDidLoad()
        configure(with: viewModel)
        setupDarkMode()
    }
    
    func setupViews() {
        view.addSubview(imageView)
        view.addSubview(sourceLabel)
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(authorNameLabel)
        view.addSubview(openInBrowserButton)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        sourceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        sourceLabel.textColor = .gray

        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = .gray
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        
        authorNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        authorNameLabel.textColor = .gray
        
        openInBrowserButton.backgroundColor = .systemBlue

        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        authorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        openInBrowserButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
    }
    
    func configure(with viewModel: DetailBusinessLayer) {
        imageView.setImage(from: viewModel.getUrlToImage())
        sourceLabel.text = viewModel.getSourceName()
        dateLabel.text = viewModel.getPublishedDate()
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getDescription()
        authorNameLabel.text = viewModel.getAuthor()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupDarkMode()
    }
    
    func setupDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            sourceLabel.textColor = .lightGray
            dateLabel.textColor = .lightGray
            titleLabel.textColor = .white
            descriptionLabel.textColor = .white
            authorNameLabel.textColor = .lightGray
            openInBrowserButton.tintColor = .white
            openInBrowserButton.backgroundColor = .gray
            
        } else {
            view.backgroundColor = .systemBackground
            sourceLabel.textColor = .gray
            dateLabel.textColor = .gray
            titleLabel.textColor = .black
            descriptionLabel.textColor = .black
            authorNameLabel.textColor = .gray
            openInBrowserButton.tintColor = .white
            openInBrowserButton.backgroundColor = .darkGray
        }
    }
    
    @objc private func openInBrowser() {
        let urlString = viewModel.getArticleURL()
        if let url = URL(string: urlString ) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid or empty URL string.")
        }
    }
}
