//
//  TabView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct FullTabPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    let currentMonth: Int = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        TabView {
            SummaryPage(viewContext: viewContext)
                .tabItem {
                    Image("summary")
                    Text("Summary")
                }
            
            AnnualListPage(viewContext: viewContext)
                .tabItem {
                    Image("year")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text("Annual")
                }
            
            MonthlyListPage(year: currentYear, month: currentMonth, viewContext: viewContext)
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
        FullTabPage()
    }
}
