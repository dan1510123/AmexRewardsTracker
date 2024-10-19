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
                    .font(.system(size: 18, weight: .semibold)) // Updated font
                    .foregroundColor(.white)
                    .padding() // Added padding for a better touch area
                    .frame(maxWidth: .infinity)
                    .background(adminMode ? Color.blue : Color.gray) // Animated color change
                    .clipShape(Capsule()) // Capsule shape for a softer look
            }
            .padding(.horizontal, 40) // Additional padding for spacing
            .padding(.bottom, 10)
        }
        .background(Color(UIColor.systemBackground))
    }
    
    private func getLeadingButton() -> some View {
        Group {
            if(adminMode) {
                    EditButton()
                        .frame(width: buttonWidth, alignment: .leading)
            } else {
                Button(action:  {
                    year = year + (Int)((month + 10) / 12 - 1)
                    month = (month + 10) % 12 + 1
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Prev")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.accentColor)
    }
    
    private func getTrailingButton() -> some View {
        Group {
            if(adminMode) {
                NavigationLink("Add Monthly Reward", destination: AddRewardPage(annual: annual, rewardType: "Monthly"))
            } else {
                Button(action:  {
                    year = year + (Int)(month / 12)
                    month = month % 12 + 1
                }){
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .foregroundColor(.accentColor)
    }
    
    private func getMonthYearString() -> String {
        // Define months array outside the string construction
        let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        // Use a separate variable to get the month name
        let monthName = (month >= 1 && month <= 12) ? months[month - 1] : "Invalid Month"
        
        return "\(monthName) \(year) Rewards"
    }
}

struct MonthlyListPage_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyListPage(year: 2024, month: 10, viewContext: PersistenceController.preview.container.viewContext)
    }
}
