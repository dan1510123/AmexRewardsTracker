//
//  ProgressBarWrapped.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/27/21.
//

import SwiftUI

struct ProgressBarWrapped: View {
    
    let rewards: FetchedResults<Reward>
    let rewardType: String
    let shadowColor: Color
    var redeemed: Float = 0
    var total: Float = 0
    @ObservedObject var annualProgress = AnnualProgress()
    
    init(rewards: FetchedResults<Reward>, rewardType: String, shadowColor: Color) {
        self.rewards = rewards
        self.rewardType = rewardType
        self.shadowColor = shadowColor
        self.setAnnualProgress()
    }
    
    private mutating func setAnnualProgress() {
        for reward in rewards {
            self.total += reward.value
            if(reward.redeemed) {
                self.redeemed += reward.value
            }
        }
        
        self.annualProgress.progBarPercentage = self.redeemed / self.total
    }
    
    var body: some View {
        Text("\(rewardType) Rewards")
            .font(.system(size: 24.0))
            .underline()
            .padding(.bottom, 10)
        Text("\(String(format: "$%.0f", self.redeemed)) of \(String(format: "$%.0f", self.total)) earned")
            .font(.system(size: 20.0))
        ProgressBar(value: $annualProgress.progBarPercentage).frame(height: 20)
            .shadow(color: shadowColor, radius: 2, x: 0, y: 0)
    }
}

class AnnualProgress: ObservableObject {
    @Published var progBarPercentage : Float = 0.0
}

struct ProgressBarWrapped_Previews: PreviewProvider {
    static var previews: some View {
        Text("")//ProgressBarWrapped()
    }
}
