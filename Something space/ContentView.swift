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
       //  PictureOfTodayView()
     //   ListView()
     //   FloatingTabBar()
        
        if global.onboardingOn {
            OnboardingManager()
        } else {
            FloatingTabBar()
        }
        
      //  ListView()
      //  FloatingPictureOfTodayView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
