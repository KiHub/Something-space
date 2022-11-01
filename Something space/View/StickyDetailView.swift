//
//  StickyDetailView.swift
//  Something space
//
//  Created by  Mr.Ki on 27.10.2022.
//

import SwiftUI

struct StickyDetailView: View {
    @Environment(\.presentationMode) var presentation
    var photo: Photo
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                ZStack {
                    
                    GeometryReader { gr in
                        
                        VStack() {
                            if let url = photo.url {
                                AsyncImage(url: url) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height:
                                                    self.calculateHeight(minHeight: 120,
                                                                         maxHeight: 300,
                                                                         yOffset: gr.frame(in: .global).origin.y))
                                            .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                                    ? abs(gr.frame(in: .global).origin.y) // down!
                                                    : -gr.frame(in: .global).origin.y) //  up!
                                        Spacer()
                                    } else if phase.error != nil {
                                        VStack {
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(Color("ColorLightShadow"))
                                                    .frame(height:
                                                            self.calculateHeight(minHeight: 120,
                                                                                 maxHeight: 200,
                                                                                 yOffset: gr.frame(in: .global).origin.y))
                                                Text("❌")
                                                    .font(.title)
                                            }
                                        }
                                        .padding()
                                        
                                    } else {
                                        HStack {
                                            Spacer()
                                            Spinner()
                                                .frame(height:
                                                        self.calculateHeight(minHeight: 120,
                                                                             maxHeight: 300,
                                                                             yOffset: gr.frame(in: .global).origin.y))
                                            Spacer()
                                        }
                                    }
                                }
                                .ignoresSafeArea(.container, edges: .top)
                            }
                        }
                    }
                    
                    VStack(spacing: 30) {
                        VStack() {
                            Text(photo.date).font(.headline)
                            Text(photo.title).font(.headline)
                        }
                        .padding()
                        .foregroundColor(Color("ColorDark"))
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        
                        Text(photo.description)
                            .shadow(color: .white, radius: 10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 350)
                    
                }.edgesIgnoringSafeArea(.vertical)
            }.navigationBarHidden(true)
            HStack(spacing: 30) {
                Button {
                    
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("\(Image(systemName: "arrow.backward"))")
                        .font(.headline)
                        .foregroundColor(Color("ColorLight"))
                        .padding()
                        .background(
                            Circle()
                                .stroke(lineWidth: 2)
                        )
                }.controlSize(.small)
                
                    .foregroundColor(Color("ColorLight"))
                
                    .padding()
                Spacer()
            }
        }
    }
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            //  UP
            // Never go smaller than our minimum height
            print("Up")
            return minHeight
        }
        print("down")
        //    DOWN
        return maxHeight + yOffset
    }
}

struct StickyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StickyDetailView(photo: Photo.createDefault())
    }
}


