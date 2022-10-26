//
//  SelectDateView.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import SwiftUI

struct SelectDateView: View {
    
    @State private var date = Date()
    
    @ObservedObject var manager: NetworkManager
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 20) {
        
            Text("Select a day 📆").font(.title)
            DatePicker("Select a day", selection: $date, in: ...Date(), displayedComponents: .date)
            Button {
                self.manager.date = self.date
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Done ✅").foregroundColor(.black)
            }
        }.padding()
            .labelsHidden()
       

    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(manager: NetworkManager())
    }
}
