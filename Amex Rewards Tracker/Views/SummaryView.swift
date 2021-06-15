//
//  SummaryView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        VStack {
            Text("Summary")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: 200, maxHeight: 50)
                .font(.title)
            List {
                ProgressTileView(rewardType: "Gold", year: currentYear)
            }
            Spacer()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
