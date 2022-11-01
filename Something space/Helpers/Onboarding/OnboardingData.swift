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
    let on: Bool
    
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "path", objectImage: "rocket", primaryText: "Are you looking for something space?", secondaryText: "If you are curious about space, it's definitely for you", on: false),
        OnboardingData(id: 1, backgroundImage: "path", objectImage: "rocket", primaryText: "Get a new picture every day", secondaryText: "And a small portion of interesting facts", on: false),
        OnboardingData(id: 2, backgroundImage: "path", objectImage: "rocket", primaryText: "Let's look at something space 🚀", secondaryText: "", on: true)
    ]
}
