//
//  UrlHelper.swift
//  Something space
//
//  Created by  Mr.Ki on 24.10.2022.
//

import Foundation

extension URL {
    func withQuery(_ query: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map{ URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
