//
//  AddMRView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct AddRewardPage: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var titleFieldText: String = ""
    @State var detailsFieldText: String = ""
    @State var yearNumber: String = "2021"
    @State var cardType: String = "Gold"
    @State var valueFieldText: String = ""
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    let annual: Bool
    let rewardType: String
    
    var body: some View {
        ScrollView {
            Text("Add \(rewardType) Reward ⭐️")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: 200, maxHeight: 50)
                .font(.title)
            VStack {
                TextField("Reward Title", text: $titleFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                
                TextField("Reward Details / Description", text: $detailsFieldText)
                    .padding(.horizontal)
                    .frame(height: 120)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                
                Picker("Year", selection: $yearNumber) {
                    ForEach(["2022", "2023"], id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker("Card", selection: $cardType) {
                    ForEach(["Gold", "Platinum", "Delta Gold", "Delta Reserve"], id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())

                TextField("Reward \(rewardType) Value", text: $valueFieldText)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                
                Button(action: onSavePressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(16)
        }
        
    }
    
    private func onSavePressed() {
        if(annual) {
            let newReward: Reward = createReward()
            newReward.annual = true
            newReward.month = 0
        }
        else {
            for month in 1...12 {
                let newReward: Reward = createReward()
                newReward.annual = false
                newReward.month = Int16(month)
            }
        }
        
        saveContext()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func createReward() -> Reward {
        let newReward = Reward(context: viewContext)
        newReward.title = titleFieldText
        newReward.details = detailsFieldText
        newReward.value = Float(valueFieldText) ?? 0
        newReward.year = Int16(yearNumber) ?? 0
        newReward.cardType = cardType
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
}

struct AddRewardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddRewardPage(annual: true, rewardType: "Monthly")
        }
    }
}
