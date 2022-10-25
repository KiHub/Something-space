//
//  PictureOfTodayView.swift
//  Something space
//
//  Created by  Mr.Ki on 24.10.2022.
//

import SwiftUI

struct PictureOfTodayView: View {
    @ObservedObject var manager = NetworkManager()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PictureOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTodayView()
    }
}
