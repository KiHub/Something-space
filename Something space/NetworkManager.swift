//
//  NetworkManager.swift
//  Something space
//
//  Created by  Mr.Ki on 24.10.2022.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var date: Date = Date()
    @Published var photo = Photo()
    @Published var image: UIImage? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        $date.removeDuplicates()
            .sink { value in
                self.image = nil
            }.store(in: &subscriptions)
        
        $date.removeDuplicates()
            .map {
                API.createURL(for: $0)
            }.flatMap { url in
                API.createPublisher(url: url)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photo, on: self)
            .store(in: &subscriptions)
        
        $photo
            .filter { $0.url != nil }
            .map { photo -> URL in
                return photo.url!
            }.flatMap { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch({error in
                        return Just(Data())
                    })
            }.map { out -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        
    }
    
}
