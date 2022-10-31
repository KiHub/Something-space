//
//  FloatingPictureOfTodayView.swift
//  Something space
//
//  Created by  Mr.Ki on 28.10.2022.
//

import SwiftUI

struct FloatingPictureOfTodayView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var manager = NetworkManager()
    @State private var showDate: Bool = false
    
    var body: some View {
        
        
        ZStack(alignment: .top) {
            
            ScrollView {
                ZStack {
                    
//                    VStack(spacing: 30) {
//                        Spacer()
//                        Text(manager.photo.date).font(.headline)
//                        //   Spacer()
//                        Text(manager.photo.title).font(.headline)
//                        //   Spacer()
//                        Text(manager.photo.description)
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, 350)
                    
                    GeometryReader { gr in
                        
                        VStack() {
                            if manager.image != nil {
                                Image(uiImage: self.manager.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height:
                                            self.calculateHeight(minHeight: 120,
                                                                 maxHeight: 300,
                                                                 yOffset: gr.frame(in: .global).origin.y))
                                    .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                            ? abs(gr.frame(in: .global).origin.y) // Push it down!
                                            : -gr.frame(in: .global).origin.y) // Push it up!
                                Spacer()
                            } else {
                                // ProgressView()
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Spinner()
                                            .frame(height:
                                                    self.calculateHeight(minHeight: 120,
                                                                         maxHeight: 300,
                                                                         yOffset: gr.frame(in: .global).origin.y))
                                        Spacer()
                                    }
                                }.padding(.vertical, 100)
                            }
                        }
                        .ignoresSafeArea(.container, edges: .top)
                    }
                    VStack(spacing: 30) {
                      //  Spacer()
                        VStack {
                        Text(manager.photo.date).font(.headline)
                        //   Spacer()
                        Text(manager.photo.title).font(.headline)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        //   Spacer()
                        Text(manager.photo.description)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 350)
                }
                //        }
            }.edgesIgnoringSafeArea(.vertical)
            //  }.navigationBarHidden(true)
            VStack() {
                
                HStack() {
                    Button {
                        
                        self.showDate.toggle()
                    } label: {
                        Text("📆").foregroundColor(Color("ColorLight"))
                            .padding()
                            .background(
                                Circle()
                                    .stroke(lineWidth: 2)
                                //  .shadow(color: Color("ColorLightShadow"), radius: 10, x: 5, y: 5)
                            )
                    }.controlSize(.small)
                        .popover(isPresented: $showDate) {
                            SelectDateView(manager: self.manager)
                        }
                        .foregroundColor(Color("ColorLight"))
                    
                        .padding()
                    Spacer()
                }
            }.padding(.vertical, 50)
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
struct FloatingPictureOfTodayView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PictureOfTodayView()
        view.manager.photo = Photo.createDefault()
        view.manager.image = UIImage(named: "preview")
        return view
    }
}

