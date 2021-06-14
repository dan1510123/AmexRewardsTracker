//
//  MRListPagesView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/12/21.
//

import SwiftUI

struct MonthlyListView: View {
    
    @State var adminMode: Bool = false
    
    let index: Int
    let year: Int
    let month: Int
    let annual = false
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        self.index = year * 100 + month
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(getMonthYearString())
                .padding(.top, 10)
                .font(.system(size: 16.0, design: .monospaced))
            NavigationView {
                ListView(index: index, annual: annual, month: month, year: year)
                    .navigationTitle("Monthly Rewards")
                    .navigationBarItems(
                        leading: getLeadingButton(),
                        trailing: getTrailingButton()
                    )
            }
            Button(action: {
                self.adminMode = !self.adminMode
            }) {
                Text("ADMIN MODE")
                    .font(.system(size: 20.0, design: .monospaced))
                    .foregroundColor(.white)
            }
            .frame(width: 160, height: 60)
            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            .cornerRadius(50)
            .padding(.bottom, 10)
        }
        .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)))
    }
    
    private func getLeadingButton() -> some View {
        if(adminMode) {
            return AnyView(EditButton())
        }
        else if(!annual) {
            return AnyView(NavigationLink("Last Month", destination: MonthlyListView(year: year, month: (month + 11) % 12)).isDetailLink(false))
        }
        else {
            return AnyView(Text(""))
        }
    }
    
    private func getTrailingButton() -> some View {
        if(adminMode) {
            return AnyView(NavigationLink("Add Monthly Reward", destination: AddRewardView(annual: annual, rewardType: "Monthly")).isDetailLink(false))
        }
        else if (!annual) {
            return AnyView(NavigationLink("Next Month", destination: MonthlyListView(year: year, month: month + 1 % 12)))
        }
        else {
            return AnyView(Text(""))
        }
    }
    
    private func getMonthYearString() -> String {
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "Decemeber"]
        
        return "\(months[month - 1]) \(year)"
    }
}

struct MonthlyListView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyListView(year: 2021, month: 06)
    }
}
