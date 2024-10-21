//
//  TabView.swift
//  Credit Card Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isSettingsPresented: Bool
    
    @State private var showPrefillGoldAlert = false
    @State private var showResetGoldAlert = false
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                isSettingsPresented = false
            }) {
                Text("Leave Settings")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                showPrefillGoldAlert = true
            }) {
                Text("Add Gold Card Rewards")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showPrefillGoldAlert) {
                Alert(
                    title: Text("Add Amex Gold Rewards"),
                    message: Text("Do you want to prefill all Amex Gold rewards? Don't click this more than once or it may reset previous run."),
                    primaryButton: .destructive(Text("Add Gold Rewards")) {
                        updatePrefillGoldRewards()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            Button(action: {
                showResetGoldAlert = true
            }) {
                Text("Reset Gold Rewards")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showResetGoldAlert) {
                Alert(
                    title: Text("Reset Gold Rewards"),
                    message: Text("Do you want to reset all Amex Gold rewards? This action cannot be undone."),
                    primaryButton: .destructive(Text("Reset Gold Rewards")) {
                        resetGoldRewards()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func updatePrefillGoldRewards() -> Void {
        let cardType = "Gold"
        
        let monthlyRewardTemplates = [
            RewardTemplate(title: "Dining Credit", details: "Grubhub, The Cheesecake Factory, Five Guys", value: 10, year: currentYear, cardType: cardType),
            RewardTemplate(title: "Uber Credit", details: "Monthly Uber Cash in-app", value: 10, year: currentYear, cardType: cardType),
            RewardTemplate(title: "Dunkin' Credit", details: "Montly Dunkin' credit", value: 7, year: currentYear, cardType: cardType)
        ]
        
        for template in monthlyRewardTemplates {
            for month in 1...12 {
                let newReward: Reward = createReward(rewardTemplate: template)
                newReward.recurrencePeriod = "month"
                newReward.month = Int16(month)
                newReward.expirationDate = getLastDayOfMonth(year: currentYear, month: month)
            }
        }
        
        let annualRewardTemplates = [
            RewardTemplate(title: "Rest Credit 1/2", details: "Jan - Jun Resy Credit", value: 50, year: currentYear, cardType: cardType),
            RewardTemplate(title: "Rest Credit 2/2", details: "Jul - Dec Resy Credit", value: 50, year: currentYear, cardType: cardType)
        ]
        
        for template in annualRewardTemplates {
            let newReward: Reward = createReward(rewardTemplate: template)
            newReward.recurrencePeriod = "year"
            newReward.expirationDate = getLastDayOfMonth(year: currentYear, month: 12)
            newReward.month = -1
        }
        
        saveContext()
    }
    
    private func resetGoldRewards() {
        let requestGoldRewards = NSFetchRequest<Reward>()
        requestGoldRewards.entity = Reward.entity()
        requestGoldRewards.predicate = NSPredicate(format: "cardType == \"Gold\"")
        do {
            let rewardsToDelete: [Reward] = try viewContext.fetch(requestGoldRewards)
            rewardsToDelete.forEach(viewContext.delete)
        }
        catch {
            print("Error in deleting Gold Reward items.")
        }
        
        saveContext()
    }
    
    private func createReward(rewardTemplate: RewardTemplate) -> Reward {
        let newReward = Reward(context: viewContext)
        
        newReward.title = rewardTemplate.title
        newReward.details = rewardTemplate.details
        newReward.value = rewardTemplate.value
        newReward.year = Int16(rewardTemplate.year)
        newReward.cardType = rewardTemplate.cardType
        newReward.redeemed = false
        
        return newReward
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    private func getLastDayOfMonth(year: Int, month: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month

        // Get the range of days in the specified month
        let range = Calendar.current.range(of: .day, in: .month, for: Calendar.current.date(from: components)!)
        
        // The last day of the month is the last element in the range
        guard let lastDay = range?.count else { return nil }
        
        // Create the date for the last day of the month
        components.day = lastDay
        return Calendar.current.date(from: components)
    }
}

struct RewardTemplate {
    var title: String
    var details: String
    var value: Float
    var year: Int
    var cardType: String
}
    
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Text("") //SettingsView()
    }
}
