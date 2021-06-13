//
//  MRListPagesView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/12/21.
//

import SwiftUI

struct MonthlyListPagesView: View {
    
    @State var index: Int
    
    let year: Int
    let month: Int
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        self.index = year * 100 + month
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: ListView(index: index - 1, annual: false, month: month, year: year, rewardType: "Monthly")) {
                        Image("leftarrow")
                            .resizable()
                            .frame(width: 40, height: 31)
                    }
                    .padding(20)
                    Spacer()
                    Text(getTextFromTag(tag: index))
                        .padding(20)
                    Spacer()
                    NavigationLink(destination: ListView(index: index + 1, annual: false, month: month, year: year, rewardType: "Monthly")) {
                        Image("rightarrow")
                            .resizable()
                            .frame(width: 40, height: 31)
                    }
                    .padding(20)
                }
                ListView(index: index, annual: false, month: month, year: year, rewardType: "Monthly")
            }
        }
        .tag(index)
    }
    
    private func getTextFromTag(tag: Int) -> String {
        let month: Int = tag % 100
        let year: Int = tag / 100
        
        return "\(month)-\(year)"
    }
}

struct MonthlyListPagesView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyListPagesView(year: 2021, month: 06)
    }
}
