//
//  AddMRView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct AddMRView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var titleFieldText: String = ""
    @State var detailsFieldText: String = ""
    @State var yearNumber: Int16 = 2021
    @State var valueFieldText: Float = 0
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Reward Title", text: $titleFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                
                TextField("Reward Details / Description", text: $detailsFieldText)
                    .padding(.horizontal)
                    .frame(height: 200)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .multilineTextAlignment(.leading)
                
                Picker("Year", selection: $yearNumber) {
                    ForEach(2021...2030, id: \.self) {
                        Text(verbatim: "\($0)")
                    }
                }
                
                TextField("Reward Monthly Value", value: $valueFieldText, formatter: NumberFormatter())
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
        .navigationTitle("Add Monthly Reward ⭐️")
    }
    
    private func onSavePressed() {
        let newMonthlyReward = MonthlyReward(context: viewContext)
        newMonthlyReward.title = titleFieldText
        newMonthlyReward.details = detailsFieldText
        newMonthlyReward.value = valueFieldText
        let x = Float(valueFieldText)
        newMonthlyReward.redeemed = false
        
        
        saveContext()
        self.presentationMode.wrappedValue.dismiss()
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

struct AddMRView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddMRView()
        }
    }
}
