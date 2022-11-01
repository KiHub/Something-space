//
//  ListNetworkManager.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import Foundation
import Combine
import SwiftUI

class ListNetworkManager: ObservableObject {
    
    
    @Published var info = [Photo]()
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var daysFromToday: Int = 0
    
    init() {
        $daysFromToday
            .map { daysFromToday in
                return API.createDate(daysFromToday: daysFromToday)
            }.map { date in
                return API.createURL(for: date)
            }.flatMap { url in
                return API.createPublisher(url: url)
            }.scan([]) { partValue, newValue in
                return partValue + [newValue]
            }
            .tryMap( { info in
                info.sorted(by: { $0.formatterDate < $1.formatterDate})
            })
        
            .catch { error in
                Just([Photo]())
            }.eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.info, on: self)
            .store(in: &subscriptions)
        
        getMore(times: 8)
        
    }
    
    func getMore(times: Int) {
        
        for _ in 0..<times {
            self.daysFromToday += 1
        }
    }
    
}
