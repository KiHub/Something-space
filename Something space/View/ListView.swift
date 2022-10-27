//
//  ListView.swift
//  Something space
//
//  Created by  Mr.Ki on 26.10.2022.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var manager = ListNetworkManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.info) { info in
                    NavigationLink(destination: StickyDetailView(photo: info)) {
                        Row(photo: info)
                    }
        
                }
                
            }
            .navigationTitle("Something space")
            .refreshable {
                manager.getMore(times: 5)
        }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
