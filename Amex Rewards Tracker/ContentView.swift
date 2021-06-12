//
//  ContentView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

import CoreData

struct Test {}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var monthlyRewards: FetchedResults<MonthlyReward>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(monthlyRewards) { reward in
                    Text((reward.title ?? "Untitled") + ": " + (reward.details ?? "No details"))
                }.onDelete(perform: deleteTasks)
            }
            .navigationTitle("Monthly Rewards List")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Add Monthly Reward") {
                addMonthlyReward()
            })
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map { monthlyRewards[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func addMonthlyReward() {
        withAnimation {
            let newMonthlyReward = MonthlyReward(context: viewContext)
            newMonthlyReward.title = "New Reward \(Int.random(in: 1..<1000))"
            newMonthlyReward.details = "Just deets"
            
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
