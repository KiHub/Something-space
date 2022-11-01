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
                                    .offset(y: gr.frame(in: .global).origin.y < 0 // going up?
                                            ? abs(gr.frame(in: .global).origin.y) // down!
                                            : -gr.frame(in: .global).origin.y) // up!
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
                        VStack {
                            Text(manager.photo.date).font(.headline)
                            Text(manager.photo.title).font(.headline)
                        }
                        .padding()
                        .foregroundColor(Color("ColorDark"))
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        Text(manager.photo.description)
                            .shadow(color: .white, radius: 10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 350)
                }
                //        }
            }.edgesIgnoringSafeArea(.vertical)
            VStack() {
                HStack() {
                    Button {
                        self.showDate.toggle()
                    } label: {
                        Text("\(Image(systemName: "doc.text.magnifyingglass"))")
                            .font(.headline)
                            .foregroundColor(Color("ColorLight"))
                            .padding()
                            .background(
                                Circle()
                                    .stroke(lineWidth: 2)
                            )
                    }
                    .imageScale(.large)
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
        let view = FloatingPictureOfTodayView()
        view.manager.photo = Photo.createDefault()
        view.manager.image = UIImage(named: "preview")
        return view
    }
}

