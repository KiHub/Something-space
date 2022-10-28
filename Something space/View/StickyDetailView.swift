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
                    VStack(spacing: 30) {
                        Spacer()
                        Text(photo.date).font(.headline)
                        //   Spacer()
                        Text(photo.title).font(.headline)
                        //   Spacer()
                        Text(photo.description)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 350)
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
                                            .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                                    ? abs(gr.frame(in: .global).origin.y) // Push it down!
                                                    : -gr.frame(in: .global).origin.y) // Push it up!
                                        Spacer()
                                    } else if phase.error != nil {
                                        HStack {
                                            Spacer()
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(Color("ColorLightShadow"))
                                                    .frame(height:
                                                            self.calculateHeight(minHeight: 120,
                                                                                 maxHeight: 200,
                                                                                 yOffset: gr.frame(in: .global).origin.y))
                                                Text("❌")
                                            }
                                            Spacer()
                                        }
                                        
                                    } else {
                                        // ProgressView()
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
                }.edgesIgnoringSafeArea(.vertical)
            }.navigationBarHidden(true)
            HStack(spacing: 30) {
                Button {
                    
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Text("⬅️").foregroundColor(Color("ColorTabLight"))
                        .padding()
                        .background(
                            Circle()
                                .stroke(lineWidth: 2)
                        )
                }.controlSize(.small)
                
                    .foregroundColor(Color("ColorTabLight"))
                
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
        DetailView(photo: Photo.createDefault())
    }
}


