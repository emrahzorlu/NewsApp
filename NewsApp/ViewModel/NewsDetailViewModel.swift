//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 5.07.2024.
//

import UIKit

protocol NewsDetailBusinessLayer: BaseViewModelProtocol {
    var view: NewsDetailDisplayLayer? { get set }
    func getTitle() -> String
    func getDescription() -> String
    func getUrlToImage() -> String
    func getSourceName() -> String
    func getPublishedDate() -> String
    func getArticleURL() -> String
    func getAuthor() -> String
    func viewDidLoad()
}

class NewsDetailViewModel: BaseViewModelProtocol {
    weak var view: NewsDetailDisplayLayer?
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
    func viewDidLoad() {
        view?.configure()
    }
}

extension NewsDetailViewModel: NewsDetailBusinessLayer {
    
    func getTitle() -> String {
        return news.title ?? ""
    }
    
    func getDescription() -> String {
        return news.description ?? ""
    }
    
    func getUrlToImage() -> String {
        return news.urlToImage ?? ""
    }

    func getSourceName() -> String {
        return news.source?.name ?? ""
    }
    
    func getArticleURL() -> String {
        return news.url ?? ""
    }
    
    func getAuthor() -> String {
        return news.author ?? ""
    }
    
    func getPublishedDate() -> String {
        return Date.formattDateString(from: news.publishedAt)
    }
}
