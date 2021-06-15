//
//  TabView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct FullTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    let currentMonth: Int = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        TabView {
            SummaryView()
                .tabItem {
                    Image("summary")
                    Text("Summary")
                }
            
            AnnualListView()
                .tabItem {
                    Image("year")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text("Annual")
                }
            
            MonthlyListView(year: currentYear, month: currentMonth)
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
