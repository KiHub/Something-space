//
//  NetworkManager.swift
//  Something space
//
//  Created by  Mr.Ki on 24.10.2022.
//
 
import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        guard let url = URL(string: Constants.baseURL) else {return}
        guard let fullURL = url.withQuery(["api_key": Constants.key]) else {return}
        print(fullURL.absoluteString)
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("fetch finished")
                case .failure(let failure):
                    print("fetch complete with failure: \(failure.localizedDescription)")
                }
                
            }) { (data, responce) in
                if let description = String(data: data, encoding: .utf8) {
                    print("fetched new data \(description)")
                }
            }.store(in: &subscriptions)
    }
}
