//
//  MRListRowView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct ListRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var reward: Reward
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
        .listRowBackground(getBackgroundColor())
        .mask(RoundedRectangle(cornerRadius: 20.0))
    }
    
    private func getBackgroundColor() -> Color {
        if(redeemed) {
            return Color(#colorLiteral(red: 0, green: 1, blue: 0.4970139265, alpha: 1))
        }
        else if (reward.cardType == "Gold") {
            return Color(#colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1))
        }
        else if (reward.cardType == "Platinum") {
            return Color(#colorLiteral(red: 0.8980392157, green: 0.8941176471, blue: 0.968627451, alpha: 1))
        }
        else if (reward.cardType == "Delta Gold") {
            return Color(#colorLiteral(red: 0.9607843137, green: 0.6901960784, blue: 0.2588235294, alpha: 1))
        }
        else if (reward.cardType == "Delta Reserve") {
            return Color(#colorLiteral(red: 0.2, green: 0.2, blue: 1, alpha: 1))
        }
        else{
            return Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
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

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ListRowView(reward: Reward(), title: "good item", details: "deets", value: 10, redeemed: true)
            ListRowView(reward: Reward(), title: "bad item", details: "deets", value: 10, redeemed: false)
        }
    }
}
