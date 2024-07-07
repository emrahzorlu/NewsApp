//
//  NewsViewModelTests.swift
//  NewsAppTests
//
//  Created by Emrah Zorlu on 6.07.2024.
//

import Foundation
@testable import NewsApp

class MockNetworkManager: NetworkServiceProtocol {
    
    var mockResult: Result<[News], NetworkError> = .failure(.fake)
    private(set) var invocations: [Invocation] = []

    enum Invocation: Equatable {
        case fetchNews
    }

    func fetchNews(page: Int, completion: @escaping (Result<[NewsApp.News], NewsApp.NetworkError>) -> Void) {
        print("fetchNews called")
        invocations.append(.fetchNews)
        completion(mockResult)
    }
}
