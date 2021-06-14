//
//  ContentView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var adminMode: Binding<Bool>
    
    let index: Int
    let annual: Bool
    let month: Int
    let year: Int
    
    var fetchRequest: FetchRequest<Reward>
    var rewards: FetchedResults<Reward> { fetchRequest.wrappedValue }
    
    init(index: Int, annual: Bool, month: Binding<Int>, year: Binding<Int>, adminMode: Binding<Bool>) {
        fetchRequest = FetchRequest<Reward>(entity: Reward.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Reward.redeemed, ascending: true),
                NSSortDescriptor(keyPath: \Reward.value, ascending: false),
                NSSortDescriptor(keyPath: \Reward.title, ascending: true)
            ],
            
            predicate: NSPredicate(format: "annual == \(annual) and month == \(month.wrappedValue) and year == \(year.wrappedValue)")
        )
        
        self.index = index
        self.annual = annual
        self.month = month.wrappedValue
        self.year = year.wrappedValue
        self.adminMode = adminMode
    }
    
    var body: some View {
        List {
            ForEach(fetchRequest.wrappedValue) { reward in
                ListRowView(reward: reward, title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value, redeemed: reward.redeemed)
            }.onDelete(perform: deleteTasks)
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
        if(adminMode.wrappedValue) {
            withAnimation {
                offsets.map { rewards[$0] }.forEach(viewContext.delete)
                saveContext()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        }
    }
}
