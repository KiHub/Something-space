//
//  StickyDetailView.swift
//  Something space
//
//  Created by  Mr.Ki on 27.10.2022.
//

import SwiftUI

struct StickyDetailView: View {
    
    var photo: Photo
    
    var body: some View {
        ScrollView {
            ZStack {
                
                VStack(spacing: 20) {
                    Text(photo.date).font(.headline)
                    Spacer()
                    Text(photo.title).font(.headline)
                    Spacer()
                    Text(photo.description)
                }
                .padding(.horizontal, 20)
                .padding(.top, 300)
                
                GeometryReader { gr in
                    
                    VStack() {
                        if let url = photo.url {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    //.frame(height: 300)
                                        .frame(height:
                                                self.calculateHeight(minHeight: 120,
                                                                     maxHeight: 300,
                                                                     yOffset: gr.frame(in: .global).origin.y))
                                        .overlay(
                                            Text(photo.title)
                                                .font(.system(size: 20, weight: .black))
                                                .foregroundColor(.white)
                                                .opacity(0.8))
                                        .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                                ? abs(gr.frame(in: .global).origin.y) // Push it down!
                                                : -gr.frame(in: .global).origin.y) // Push it up!
                                    Spacer()
                                } else if phase.error != nil {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(.gray)
                                        Text("❌")
                                    }
                                } else {
                                    // ProgressView()
                                    //  Spacer()
                                    Spinner()
                                    //  Spacer()
                                }
                            }
                            .ignoresSafeArea(.container, edges: .top)
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.vertical)
        }
    }
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            //  UP
            // Never go smaller than our minimum height
            return minHeight
        }
        //        else if maxHeight + yOffset > maxHeight {
        //                // SCROLLING DOWN PAST MAX HEIGHT
        //                return maxHeight + (yOffset * 0.5) // Lessen the offset
        //            }
        //    DOWN
        return maxHeight + yOffset
    }
    
}

struct StickyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photo: Photo.createDefault())
    }
}


