//
//  NewsModel.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 4.07.2024.
//

import Foundation

struct News: Decodable {
    let title: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    let source: Source?
    let publishedAt: String?
    let url: String?
    let author: String?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case content
        case source
        case publishedAt
        case url
        case author
    }

    struct Source: Decodable {
        let name: String
    }
}
