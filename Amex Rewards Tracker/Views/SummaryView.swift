//
//  SummaryView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI
import CoreData

struct SummaryView: View {
    
    let viewContext: NSManagedObjectContext
    @State var year: Int = Calendar.current.component(.year, from: Date())
    
    let buttonWidth: CGFloat = 180
    
    var body: some View {
        VStack {
            HStack {
                getLeadingButton()
                getTrailingButton()
            }
            Text("\(year) Summary".replacingOccurrences(of: ",", with: ""))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: 200, maxHeight: 50)
                .font(.title)
            List {
                ProgressTileView(rewardType: "Total", year: year, shadowColor: Color.red)
                ProgressTileView(rewardType: "Platinum", year: year, shadowColor: Color.black)
                ProgressTileView(rewardType: "Gold", year: year, shadowColor: Color.yellow)
            }
            Spacer()
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
