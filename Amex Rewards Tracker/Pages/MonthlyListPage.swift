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
    @State var month: Int = 1
    @State var year: Int = 1
    
    let viewContext: NSManagedObjectContext
    let index: Int
    let annual = false
    
    let buttonWidth: CGFloat = 180
    
    let monthNames: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
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
                    .foregroundColor(.primary)
                    .navigationBarItems(
                        leading: getLeadingButton(),
                        trailing: getTrailingButton()
                    )
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.adminMode.toggle()
                }
            }) {
                Text("ADMIN MODE")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(adminMode ? Color.blue : Color.gray)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
        }
        .background(Color(UIColor.systemBackground))
    }
    
    private func getLeadingButton() -> some View {
        Group {
            if adminMode {
                    EditButton()
                        .frame(width: buttonWidth, alignment: .leading)
            } else {
                if month != 1 {
                    Button(action:  {
                        year = year + (Int)((month + 10) / 12 - 1)
                        month = (month + 10) % 12 + 1
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(monthNames[month - 2])
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.accentColor)
    }
    
    private func getTrailingButton() -> some View {
        Group {
            if adminMode {
                NavigationLink("Add Monthly Reward", destination: AddRewardPage(annual: annual, rewardType: "Monthly"))
            } else {
                if month != 12 {
                    Button(action:  {
                        year = year + (Int)(month / 12)
                        month = month + 1
                    }){
                        HStack {
                            Text(monthNames[month])
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .foregroundColor(.accentColor)
    }
    
    private func getMonthYearString() -> String {
        // Use a separate variable to get the month name
        let monthName = (month >= 1 && month <= 12) ? monthNames[month - 1] : "Invalid Month"
        
        return "\(monthName) \(year) Rewards"
    }
}

struct MonthlyListPage_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyListPage(year: 2024, month: 10, viewContext: PersistenceController.preview.container.viewContext)
    }
}
