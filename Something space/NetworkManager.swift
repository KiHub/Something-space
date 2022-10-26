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
    
    @Published var photo = Photo()
    @Published var image: UIImage? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        guard let url = URL(string: Constants.baseURL) else {return}
        guard let fullURL = url.withQuery(["api_key": Constants.key]) else {return}
        print(fullURL)
        print(fullURL.absoluteString)
        
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .map(\.data)
            .decode(type: Photo.self, decoder: JSONDecoder())
            .catch { (error) in
                Just(Photo())
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photo, on: self)
            .store(in: &subscriptions)
        
        $photo
            .filter { $0.url != nil }
            .map { photo -> URL in
                return photo.url!
            }.flatMap { (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch({error in
                        return Just(Data())
                    })
            }.map { (out) -> UIImage? in
            UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .finished:
//                    print("fetch finished")
//                case .failure(let failure):
//                    print("fetch complete with failure: \(failure.localizedDescription)")
//                }
//
//            }) { (data, responce) in
//                if let description = String(data: data, encoding: .utf8) {
//                    print("fetched new data \(description)")
//                }
//            }.store(in: &subscriptions)
    }
}
