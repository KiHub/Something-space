//
//  API.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import Foundation
import Combine

struct API {
    static func createURL(for date: Date) -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let url = URL(string: Constants.baseURL)!
        let fullURL = url.withQuery(["api_key": Constants.key, "date": dateString])!
        return fullURL
    }
    
    static func createDate(daysFromToday: Int) -> Date {
        let today = Date()
        if let newDate = Calendar.current.date(byAdding: .day, value: -daysFromToday, to: today) {
            return newDate
        } else {
            return today
        }
    }
    
    static func createPublisher(url: URL) -> AnyPublisher<Photo, Never> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Photo.self, decoder: JSONDecoder())
            .catch { (error) in
                Just(Photo())
            }
            .eraseToAnyPublisher()
    
    
        
    }
    
}
