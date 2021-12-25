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
    let barColor: Color
    var redeemed: Float = 0
    var total: Float = 0
    var progressPercent: Float = 0
    
    init(rewards: FetchedResults<Reward>, rewardType: String, barColor: Color) {
        self.rewards = rewards
        self.rewardType = rewardType
        self.barColor = barColor
        self.setAnnualProgress()
    }
    
    private mutating func setAnnualProgress() {
        for reward in rewards {
            self.total += reward.value
            if(reward.redeemed) {
                self.redeemed += reward.value
            }
        }
        if self.total > 0 {
            self.progressPercent = self.redeemed / self.total
        }
    }
    
    var body: some View {
        Text("\(rewardType) Rewards")
            .font(.system(size: 24.0))
            .underline()
            .padding(.bottom, 10)
        Text("\(String(format: "$%.0f", self.redeemed)) of \(String(format: "$%.0f", self.total)) earned")
            .font(.system(size: 20.0))
        ProgressBar(value: progressPercent, color: barColor).frame(height: 20)
    }
}

struct ProgressBarWrapped_Previews: PreviewProvider {
    static var previews: some View {
        Text("")//ProgressBarWrapped()
    }
}
