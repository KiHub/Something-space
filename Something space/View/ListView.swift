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
        List {
            ForEach(manager.info) { info in
                Text(info.title)
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
