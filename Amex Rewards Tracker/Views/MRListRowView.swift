//
//  MRListRowView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct MRListRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var reward: MonthlyReward
    let title: String
    let details: String
    let value: Float
    @State var redeemed: Bool
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(title)
                    Spacer()
                    Text("\(String(format: "$%.2f", value))")
                }
                
                Text(details)
                    .frame(width: 200,height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            Button(action: {
                onCheckPressed()
            }, label: {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
            })
            .padding(10)
        }
        .padding(20)
        .background(getBackgroundColor())
        .mask(RoundedRectangle(cornerRadius: 20.0))
    }
    
    private func getBackgroundColor() -> Color {
        return redeemed ? Color(#colorLiteral(red: 0, green: 1, blue: 0.4970139265, alpha: 1)) : Color(#colorLiteral(red: 1, green: 0.9490906596, blue: 0.1527474225, alpha: 1))
    }
    
    private func onCheckPressed() {
        redeemed = !redeemed
        reward.redeemed = redeemed
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
}

struct MRListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MRListRowView(reward: MonthlyReward(), title: "good item", details: "deets", value: 10, redeemed: true)
            MRListRowView(reward: MonthlyReward(), title: "bad item", details: "deets", value: 10, redeemed: false)
        }
    }
}
