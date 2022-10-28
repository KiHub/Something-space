//
//  PictureOfTodayView.swift
//  Something space
//
//  Created by  Mr.Ki on 24.10.2022.
//

import SwiftUI

struct PictureOfTodayView: View {
    
    @ObservedObject var manager = NetworkManager()
    @State private var showDate: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            HStack() {
                Spacer()
                Button {
                    self.showDate.toggle()
                } label: {
                    Text("Change date")
                    Image(systemName: "list.number")
                   
                }.foregroundColor(.black)
                    .popover(isPresented: $showDate) {
                        SelectDateView(manager: self.manager)
                    }


            }
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            } else {
                ZStack {
                    Spinner()
                   // Text("🛸🛸🛸").font(.title)
                }
                }
            ScrollView() {
                Text(manager.photo.date).font(.headline)
                Spacer()
                Text(manager.photo.title).font(.headline)
                Spacer()
            Text(manager.photo.description)
            }
        }
        .padding()
        
    }
}
struct PictureOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PictureOfTodayView()
        view.manager.photo = Photo.createDefault()
        view.manager.image = UIImage(named: "preview")
        return view
    }
}

