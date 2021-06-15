//
//  ProgressTileView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI
import CoreData

struct ProgressTileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var annualProgress: Float = 0.42
    var fetchRequest: FetchRequest<Reward>
    var rewards: FetchedResults<Reward> { fetchRequest.wrappedValue }
    
    let rewardType: String
    let year: Int
    let saved: Int = 0
    let total: Int = 0
    
    init(rewardType: String, year: Int) {
        self.rewardType = rewardType
        self.year = year
        var predicate = NSPredicate(format: "year == \(year)")
        if(rewardType != "Total") {
            predicate = NSPredicate(format: "year == \(year) and cardType == \"\(rewardType)\"")
        }
        fetchRequest = FetchRequest<Reward>(entity: Reward.entity(),
            sortDescriptors: [],
            predicate: predicate
        )
        
        setSaved()
        setTotal()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(rewardType) Rewards")
                .font(.system(size: 24.0))
                .underline()
                .padding(.bottom, 10)
            Text("$\(saved) of $\(total) earned")
                .font(.system(size: 20.0))
            ProgressBar(value: $annualProgress).frame(height: 20)
            Spacer()
        }.padding()
    }
    
    private func setSaved() {
        let r = rewards
        for x in r {
            print(r)
        }
    }
    
    private func setTotal() {
        
    }
}

struct ProgressTileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProgressTileView(rewardType: "Gold", year: 2021)
//            ProgressTileView(rewardType: "Platinum", year: 2021)
//            ProgressTileView(rewardType: "Total", year: 2021)
        }
    }
}
