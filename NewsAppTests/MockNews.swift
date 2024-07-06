//
//  MockNews.swift
//  NewsAppTests
//
//  Created by Emrah Zorlu on 6.07.2024.
//

import Foundation
@testable import NewsApp

extension News {
    static func fake (
        title: String? = "",
        description: String? = "",
        urlToImage: String? = "",
        content: String? = "",
        source: Source? = nil,
        publishedAt: String? = "",
        url: String? = "",
        author: String? = ""
    ) -> News {
        return News(title: title,
                    description: description,
                    urlToImage: urlToImage,
                    content: content,
                    source: source,
                    publishedAt: publishedAt,
                    url: url,
                    author: author
        )
    }
}
