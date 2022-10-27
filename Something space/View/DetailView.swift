//
//  DetailView.swift
//  Something space
//
//  Created by  Mr.Ki on 27.10.2022.
//

import SwiftUI

struct DetailView: View {
    
    var photo: Photo
    
    var body: some View {
        VStack(spacing: 20) {
            if let url = photo.url {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        
                        image
                            .resizable()
                    }
                    
                    else if phase.error != nil {
                        ZStack {
                            
                            Circle()
                                .foregroundColor(.gray)
                            Text("❌")
                            
                        }
                        
                    } else {
                        // ProgressView()
                        Spacer()
                        Spinner()
                        Spacer()
                    }
                }
                
                .ignoresSafeArea(.container, edges: .top)
                
            }
            
            ScrollView() {
                Text(photo.date).font(.headline)
                Spacer()
                Text(photo.title).font(.headline)
                Spacer()
                Text(photo.description)
            }
        }
        //  .padding()
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: Photo.createDefault())
    }
}
