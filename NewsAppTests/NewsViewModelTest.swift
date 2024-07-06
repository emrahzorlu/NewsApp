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
        XCTAssertEqual(viewModel.numberOfNews(), 1)

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
        XCTAssertEqual(viewModel.numberOfNews(), 0)
    }
}
