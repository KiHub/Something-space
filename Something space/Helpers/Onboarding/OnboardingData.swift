//
//  OnboardingData.swift
//  Something space
//
//  Created by  Mr.Ki on 31.10.2022.
//

import Foundation

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let objectImage: String
    let primaryText: String
    let secondaryText: String
    
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "path", objectImage: "pro", primaryText: "Are you looking for something space?", secondaryText: "If you are curious about space, it's definitely for you"),
        OnboardingData(id: 1, backgroundImage: "path", objectImage: "pro", primaryText: "Get a new picture every day", secondaryText: "And a small portion of interesting facts"),
        OnboardingData(id: 2, backgroundImage: "path", objectImage: "pro", primaryText: "Ready for space adventure?", secondaryText: "")
    ]
}
