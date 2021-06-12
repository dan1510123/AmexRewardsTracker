//
//  MRListPagesView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/12/21.
//

import SwiftUI

struct MRListPagesView: View {
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    
    var body: some View {
        TabView(selection: self.$index) {
            ListView(index: 202105, annual: true)
            ListView(index: 202106, annual: false)
            ListView(index: 202107, annual: false)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct MRListPagesView_Previews: PreviewProvider {
    static var previews: some View {
        MRListPagesView()
    }
}
