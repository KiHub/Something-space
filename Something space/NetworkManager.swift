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
//        guard let url = URL(string: Constants.baseURL) else {return}
//        guard let fullURL = url.withQuery(["api_key": Constants.key]) else {return}
//        print(fullURL)
//        print(fullURL.absoluteString)
        
        $date.removeDuplicates()
            .sink { value in
                self.image = nil
            }.store(in: &subscriptions)
        
        $date.removeDuplicates()
            .map {
                API.createURL(for: $0)
            }.flatMap { url in
//                URLSession.shared.dataTaskPublisher(for: url)
//                    .map(\.data)
//                    .decode(type: Photo.self, decoder: JSONDecoder())
//                    .catch { (error) in
//                        Just(Photo())
//                    }
                API.createPublisher(url: url)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photo, on: self)
            .store(in: &subscriptions)
        
//        URLSession.shared.dataTaskPublisher(for: fullURL)
//            .map(\.data)
//            .decode(type: Photo.self, decoder: JSONDecoder())
//            .catch { (error) in
//                Just(Photo())
//            }
//            .receive(on: RunLoop.main)
//            .assign(to: \.photo, on: self)
//            .store(in: &subscriptions)
        
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
    
//    func createURL(for date: Date) -> URL {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let dateString = formatter.string(from: date)
//        let url = URL(string: Constants.baseURL)!
//        let fullURL = url.withQuery(["api_key": Constants.key, "date": dateString])!
//        return fullURL
//    }
    
}
