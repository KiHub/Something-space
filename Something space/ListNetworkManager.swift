//
//  ListNetworkManager.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import Foundation
import Combine

class ListNetworkManager: ObservableObject {
    @Published var info = [Photo]()
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        let times = 0..<10
        times.publisher
            .map { daysFromToday in
                return API.createDate(daysFromToday: daysFromToday)
            }.map { date in
                return API.createURL(for: date)
            }.flatMap { url in
                return API.createPublisher(url: url)
            }.scan([]) { partValue, newValue in
                return partValue + [newValue]
            }
            .receive(on: RunLoop.main)
            .assign(to: \.info, on: self)
            .store(in: &subscriptions)
    }
    
}
