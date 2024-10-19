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
    
    // Custom colors
    private let selectedTabColor = Color.blue
    private let unselectedTabColor = Color.gray.opacity(0.8)
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                SummaryPage(viewContext: viewContext)
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet.rectangle")
                                .font(.system(size: 22))
                            Text("Summary")
                        }
                    }
                
                AnnualListPage(viewContext: viewContext)
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar.circle")
                                .font(.system(size: 22))
                            Text("Annual")
                        }
                    }
                
                MonthlyListPage(year: currentYear, month: currentMonth, viewContext: viewContext)
                    .tabItem {
                        VStack {
                            Image(systemName: "calendar")
                                .font(.system(size: 22))
                            Text("Monthly")
                        }
                    }
                
                MonthlyListPage(year: currentYear, month: currentMonth, viewContext: viewContext)
                    .tabItem {
                        VStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 22))
                            Text("Limited Time")
                        }
                    }
            }
            .accentColor(selectedTabColor)
            .onAppear {
                UITabBar.appearance().backgroundColor = UIColor.systemGray6
                UITabBar.appearance().isTranslucent = true
                UITabBar.appearance().shadowImage = UIImage()
                UITabBar.appearance().backgroundImage = UIImage()
            }
        }
    }
}
    
struct FullTabView_Previews: PreviewProvider {
    static var previews: some View {
        FullTabPage()
    }
}
