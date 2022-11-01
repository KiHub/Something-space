//
//  ContentView.swift
//  Something space
//
//  Created by  Mr.Ki on 21.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var global = Global()
    
    var body: some View {
        
        if global.onboardingOn {
            OnboardingManager()
        } else {
            FloatingTabBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
