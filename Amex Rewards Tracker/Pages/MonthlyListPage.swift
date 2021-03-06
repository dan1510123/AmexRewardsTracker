//
//  MRListPagesView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/12/21.
//

import SwiftUI
import CoreData

struct MonthlyListPage: View {
    
    @State var adminMode: Bool = false
    @State var month: Int
    @State var year: Int
    
    let viewContext: NSManagedObjectContext
    let index: Int
    let annual = false
    
    let buttonWidth: CGFloat = 180
    
    init(year: Int, month: Int, viewContext: NSManagedObjectContext) {
        self.year = year
        self.month = month
        self.index = year * 100 + month
        self.viewContext = viewContext
    }
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationView {
                ListView(index: index, annual: annual, month: $month, year: $year, adminMode: $adminMode, viewContext: viewContext)
                    .navigationTitle(getMonthYearString())
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
            return AnyView(
                EditButton()
                    .frame(width: buttonWidth, alignment: .leading)
            )
        }
        else {
            return AnyView(
                Button("Last Month", action:  {
                    year = year + (Int)((month + 10) / 12 - 1)
                    month = (month + 10) % 12 + 1
                })
                .frame(width: buttonWidth, alignment: .leading)
            )
        }
    }
    
    private func getTrailingButton() -> some View {
        if(adminMode) {
            return AnyView(
                NavigationLink("Add Monthly Reward", destination: AddRewardPage(annual: annual, rewardType: "Monthly"))
                    .frame(width: buttonWidth, alignment: .trailing)
            )
        }
        else {
            return AnyView(
                Button("Next Month", action:  {
                    year = year + (Int)(month / 12)
                    month = month % 12 + 1
                })
                .frame(width: buttonWidth, alignment: .trailing)
            )
        }
    }
    
    private func getMonthYearString() -> String {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        return "\(months[month - 1]) \(year) Rewards"
    }
}

struct MonthlyListView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")//MonthlyListView(year: 2021, month: 06)
    }
}
