//
//  ContentView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var monthlyRewards: FetchedResults<MonthlyReward>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(monthlyRewards) { reward in
                    MRListRowView(title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value)
                }.onDelete(perform: deleteTasks)
            }
            .listStyle(DefaultListStyle())
            .navigationTitle("Monthly Rewards")
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Add Monthly Reward", destination: AddMRView())
            )
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
