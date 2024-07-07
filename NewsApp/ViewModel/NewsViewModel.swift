//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import Foundation

protocol NewsBusinessLayer: BaseViewModelProtocol {
    var view: NewsDisplayLayer? { get set }
    func getNews()
    func getMoreNews()
}

class NewsViewModel {
    weak var view: NewsDisplayLayer?
    private let networkManager: NetworkServiceProtocol
    private var dataSource: DataSource
    private var isResultsEmpty: Bool = false
    private var page = 1
    
    
    init(networkManager: NetworkServiceProtocol = NetworkManager(), dataSource: DataSource = DataSource()) {
        self.networkManager = networkManager
        self.dataSource = dataSource
    }
    
    func viewDidLoad() {
        view?.startAnimating()
        getNews()
    }

    private func createSection(news: [News]) {
        let section = NewsListSection(cellModels: news) { selectedNews in
            self.didSelectedItem(model: selectedNews)
        } loadmoreDataHandler:  { [weak self] in
            self?.getMoreNews()
            
        }
        dataSource.sections = [section]
        view?.setDataSource(dataSource: dataSource)
    }
    
    private func appendNewResults(_ newResults: [News]) {
        guard var section = dataSource.sections.first as? NewsListSection else { return }
        section.appendCellModels(newElements: newResults)
        dataSource.sections = [section]
    }
    
    private func didSelectedItem(model: News) {
        let detailViewModel = NewsDetailViewModel(news: model)
        let detailViewController = NewsDetailViewController(viewModel: detailViewModel)
        view?.pushViewController(viewController: detailViewController)
    }
}
extension NewsViewModel: NewsBusinessLayer {
    
    func getNews() {
        networkManager.fetchNews(page: 1) { [weak self] result in
            switch result {
            case .success(let news):
                self?.createSection(news: news)
            case .failure(let error):
                print("Failed to fetch news:", error)
            }
            self?.view?.stopAnimating()
        }
    }
    
    func getMoreNews() {
        page += 1
        networkManager.fetchNews(page: page) { [weak self] result in
            switch result {
            case.success(let results):
                if !results.isEmpty {
                    self?.appendNewResults(results)
                    self?.view?.reloadCollectionView()
                } else {
                    self?.isResultsEmpty = true
                }
            case.failure(let error):
                print("Error occurred while loading more results: \(error)")
            }
            self?.view?.stopAnimating()
        }
    }
}
