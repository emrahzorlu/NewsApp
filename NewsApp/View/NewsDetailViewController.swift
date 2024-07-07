//
// NewsDetailViewController.swift
// NewsApp
//
// Created by Emrah Zorlu on 4.07.2024.

import UIKit
import SnapKit
import SafariServices

protocol NewsDetailDisplayLayer: BaseControllerProtocol {
    func configure()
}

class NewsDetailViewController: UIViewController {
    
    var viewModel: NewsDetailBusinessLayer
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
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
    
    init(viewModel: NewsDetailBusinessLayer) {
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
        setupDarkMode()
        setupViews()
        configure()
    }
    
    private func setupViews() {
        setupOpenInBrowserButton()
        setupScrollView()
        setupContentView()
        setupImageView()
        setupSourceLabel()
        setupDateLabel()
        setupTitleLabel()
        setupDescriptionLabel()
        setupAuthorNameLabel()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(view.snp.height).multipliedBy(0.33)
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(openInBrowserButton.snp.top).offset(-20)
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
    
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func setupSourceLabel() {
        contentView.addSubview(sourceLabel)
        sourceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        sourceLabel.textColor = .gray
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = .gray
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)

        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupAuthorNameLabel() {
        contentView.addSubview(authorNameLabel)

        authorNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        authorNameLabel.textColor = .gray
        
        authorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func setupOpenInBrowserButton() {
        view.addSubview(openInBrowserButton)
        
        openInBrowserButton.backgroundColor = .systemBlue
        
        openInBrowserButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupDarkMode()
    }
    
    func setupDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            contentView.backgroundColor = .black
            sourceLabel.textColor = .lightGray
            dateLabel.textColor = .lightGray
            titleLabel.textColor = .white
            descriptionLabel.textColor = .white
            authorNameLabel.textColor = .lightGray
            openInBrowserButton.tintColor = .white
            openInBrowserButton.backgroundColor = .gray
        } else {
            view.backgroundColor = .systemBackground
            contentView.backgroundColor = .systemBackground
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
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid or empty URL string.")
        }
    }
}

extension NewsDetailViewController: NewsDetailDisplayLayer {
    
    func configure() {
        imageView.setImage(from: viewModel.getUrlToImage())
        sourceLabel.text = viewModel.getSourceName()
        dateLabel.text = viewModel.getPublishedDate()
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getDescription()
        authorNameLabel.text = viewModel.getAuthor()
    }
}
