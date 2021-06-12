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
                    Image("summary")
                    Text("Summary")
                }
            
            Text("Under construction...")
                .tabItem {
                    Image("year")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text("Annual")
                }
            
            MRListPagesView()
                .tabItem {
                    Image("month")
                        .resizable()
                        .frame(width: 10, height: 10)
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
