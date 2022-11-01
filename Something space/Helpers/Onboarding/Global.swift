//
//  Global.swift
//  Something space
//
//  Created by  Mr.Ki on 31.10.2022.
//

import SwiftUI

class Global: ObservableObject {
    @AppStorage("showOnboarding") var onboardingOn: Bool = true
}
