//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 5.07.2024.
//

import UIKit

protocol DetailBusinessLayer: BaseViewModelProtocol {
    var view: DetailDisplayLayer? { get set }
    func getTitle() -> String
    func getDescription() -> String
    func getUrlToImage() -> String
    func getSourceName() -> String
    func getPublishedDate() -> String
    func getArticleURL() -> String
    func getAuthor() -> String
    func viewDidLoad()
}

class NewsDetailViewModel: DetailBusinessLayer {
    weak var view: DetailDisplayLayer?
    private let news: News
    
    init(news: News) {
        self.news = news
    }
    
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
        guard let publishedAt = news.publishedAt else { return "" }
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: publishedAt) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return ""
    }

    func viewDidLoad() {
        view?.setupViews()
        view?.configure(with: self)
    }
}
