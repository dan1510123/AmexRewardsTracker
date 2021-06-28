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
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ProgressBarWrapped(rewards: self.rewards, rewardType: rewardType)
            Spacer()
        }.padding()
    }
    
    private func getProgress(rewards: [Reward]) {
        let r = self.fetchRequest.wrappedValue
        print(r)
        for x in r {
            print(x)
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
