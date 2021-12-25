//
//  SummaryView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI
import CoreData

struct SummaryPage: View {
    
    let viewContext: NSManagedObjectContext
    @State var year: Int = Calendar.current.component(.year, from: Date())
    
    let buttonWidth: CGFloat = 180
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ProgressTileView(rewardType: "Total", year: year, shadowColor: Color.red)
                    ProgressTileView(rewardType: "Platinum", year: year, shadowColor: Color.black)
                    ProgressTileView(rewardType: "Gold", year: year, shadowColor: Color.yellow)
                }
                .navigationTitle("\(year) Overview".replacingOccurrences(of: ",", with: ""))
                .navigationBarItems(
                    leading: getLeadingButton(),
                    trailing: getTrailingButton()
                )
            }
            .background(Color.white)
        }
    }
    
    private func getLeadingButton() -> some View {
        return AnyView(
            Button("Last Year", action:  {
                year = year - 1
            })
            .frame(width: buttonWidth, alignment: .leading)
        )
    }
    
    private func getTrailingButton() -> some View {
        return AnyView(
            Button("Next Year", action:  {
                year = year + 1
            })
            .frame(width: buttonWidth, alignment: .trailing)
        )
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")//SummaryView()
    }
}
