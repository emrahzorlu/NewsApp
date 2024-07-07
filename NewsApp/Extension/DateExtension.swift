//
//  DateExtension.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 7.07.2024.
//

import Foundation

extension Date {
    static func formattDateString(from dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return ""
    }
}
