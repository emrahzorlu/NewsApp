//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import Foundation

protocol MainBusinessLayer: BaseViewModelProtocol {
    var view: MainDisplayLayer? { get set }
    func getNews()
}

class NewsViewModel: MainBusinessLayer {
    weak var view: MainDisplayLayer?
    private let networkManager: NetworkServiceProtocol
    private var news: [News] = []
    private var dataSource: DataSource
    
    init(networkManager: NetworkServiceProtocol = NetworkManager(), dataSource: DataSource = DataSource()) {
        self.networkManager = networkManager
        self.dataSource = dataSource
    }
    
    func viewDidLoad() {
        view?.setupUI()
        getNews()
    }
    
    func getNews() {
        networkManager.fetchNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                self?.createSection()
                self?.view?.reloadCollectionView()
            case .failure(let error):
                print("Failed to fetch news:", error)
            }
            self?.view?.reloadCollectionView()
        }
    }

    func createSection() {
        let section = NewsListSection(cellModels: news) { selectedNews in
            self.didSelectedItem(model: selectedNews)
        }
        dataSource.sections = [section]
        view?.setDataSource(dataSource: dataSource)
        view?.reloadCollectionView()
    }
    
    func didSelectedItem(model: News) {
        let detailViewModel = NewsDetailViewModel(news: model)
        let detailViewController = NewsDetailViewController(viewModel: detailViewModel)
        view?.pushViewController(viewController: detailViewController)
    }
    
    func numberOfNews() -> Int {
        return news.count
    }

    func news(at index: Int) -> News? {
        guard index < news.count else { return nil }
        return news[index]
    }
}
