//
//  NewsViewModelTest.swift
//  NewsAppTests
//
//  Created by Emrah Zorlu on 6.07.2024.
//

import XCTest
@testable import NewsApp

class NewsViewModelTest: XCTestCase {
    private let service = MockNetworkManager()
    private let mockDataSource = DataSource()
    
    private func buildViewModel() -> NewsViewModel {
        return NewsViewModel(networkManager: service, dataSource: mockDataSource)
    }
    
    func testFetchNewsSuccess() {
        let viewModel = buildViewModel()
        
        let serviceResponse: [News] = [.fake(
            title: "test.url",
            description: "Test Title"
        )]
        
        service.mockResult = .success(serviceResponse)
        
        viewModel.getNews()
        
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations, [.fetchNews])

        XCTAssertEqual(
            (mockDataSource.sections[0] as? NewsListSection)?.cellModels.map(\.title),
            serviceResponse.map(\.title)
        )
    }
    
    func testFetchNewsNoData() {
        let viewModel = buildViewModel()
        
        service.mockResult = .failure(.noData)
        
        viewModel.getNews()
        
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations, [.fetchNews])
    }
    
    func testGetMoreNewsSuccess() {
        let viewModel = buildViewModel()
        
        let initialResponse: [News] = [.fake(
            title: "Initial Title",
            description: "Initial Description"
        )]
        
        service.mockResult = .success(initialResponse)
        
        viewModel.getNews()
        
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations, [.fetchNews])
        
        let moreNewsResponse: [News] = [.fake(
            title: "More Title",
            description: "More Description"
        )]
        
        service.mockResult = .success(moreNewsResponse)
        
        viewModel.getMoreNews()
        
        XCTAssertEqual(service.invocations.count, 2)
        XCTAssertEqual(service.invocations, [.fetchNews, .fetchNews])
        
        XCTAssertEqual(
            (mockDataSource.sections[0] as? NewsListSection)?.cellModels.map(\.title),
            initialResponse.map(\.title) + moreNewsResponse.map(\.title)
        )
    }
}
