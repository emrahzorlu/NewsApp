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
    
    func fetchNews(completion: @escaping (Result<[News], NetworkError >) -> Void) {
        print("fetchNews called")
        invocations.append(.fetchNews)
        completion(mockResult)
    }
}
