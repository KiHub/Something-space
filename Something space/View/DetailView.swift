//
//  DetailView.swift
//  Something space
//
//  Created by  Mr.Ki on 27.10.2022.
//

import SwiftUI

struct DetailView: View {
    
    let photo: Photo
    
    var body: some View {
        VStack() {
            
//            if manager.image != nil {
//                Image(uiImage: self.manager.image!)
//                    .resizable()
//                    .scaledToFit()
//                    .cornerRadius(20)
//            } else {
//                ZStack {
//                  //  RoundedRectangle(cornerRadius: 20).fill(.gray).opacity(20)
//                    Spinner()
//                   // Text("🛸🛸🛸").font(.title)
//                }
//                }
            
            if let url = photo.url {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                          //  .aspectRatio(contentMode: .fit)
                          //  .clipShape(Circle())
                    } else if phase.error != nil {
                        ZStack {
                           
                            Circle()
                                .foregroundColor(.gray)
                            Text("❌")
                        }
                        
                    } else {
                       // ProgressView()
                        Spinner()
                    }
                }
             
                .ignoresSafeArea(.container, edges: .top)
             //   .ignoresSafeArea()
              //  .frame(width: 80, height: 80)
            }
            
            
            ScrollView() {
                Text(photo.date).font(.headline)
                Spacer()
                Text(photo.title).font(.headline)
                Spacer()
            Text(photo.description)
            }
        }
        .padding()
            
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: Photo.createDefault())
    }
}
