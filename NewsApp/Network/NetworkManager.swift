//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case fake
}

protocol NetworkServiceProtocol {
    func fetchNews(completion: @escaping (Result<[News], NetworkError>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    func fetchNews(completion: @escaping (Result<[News], NetworkError>) -> Void) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&pageSize=40&apiKey=7b179609f6384bd49cd78ff837fbe1a0"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.articles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }
        task.resume()
    }
}

struct NewsResponse: Decodable {
    let articles: [News]
}
