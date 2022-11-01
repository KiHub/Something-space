//
//  Row.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import SwiftUI

struct Row: View {
    
    let photo: Photo
    
    var body: some View {
        HStack() {
            if let url = photo.url {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        ZStack {
                            
                            Circle()
                                .foregroundColor(Color("ColorLightShadow"))
                            Text("❌")
                        } 
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 80, height: 80)
            }
            VStack(alignment: .leading) {
                Text(photo.date)
                Text(photo.title).font(.headline)
            }
            
            Spacer()
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(photo: Photo.createDefault())
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
