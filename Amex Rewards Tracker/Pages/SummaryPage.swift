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
                    ProgressTileView(rewardType: "Total",
                                     year: year,
                                     barColor: Color.blue)
                    ProgressTileView(rewardType: "Platinum",
                                     year: year,
                                     barColor: .gray)
                    ProgressTileView(rewardType: "Gold",
                                     year: year,
                                     barColor: Color(#colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)))
                }
                .navigationTitle("\(year) Rewards".replacingOccurrences(of: ",", with: ""))
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
