//
//  TabView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct FullTabView: View {
    var body: some View {
        TabView {
            Text("Under construction...")
                .tabItem {
                    Image("house.fill")
                    Text("Summary")
                }
            
            Text("Under construction...")
                .tabItem {
                    Image("house.fill")
                    Text("Annual")
                }
            
            MRListView()
                .tabItem {
                    Image("list.dash")
                    Text("Monthly")
                }
        }
    }
}

struct FullTabView_Previews: PreviewProvider {
    static var previews: some View {
        FullTabView()
    }
}
