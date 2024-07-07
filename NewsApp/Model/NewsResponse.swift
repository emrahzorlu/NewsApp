//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 7.07.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [News]
}
