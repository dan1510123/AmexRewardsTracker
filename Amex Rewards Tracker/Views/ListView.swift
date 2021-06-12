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
    
    let index: Int
    let annual: Bool
    let month: Int
    let year: Int
    
    var fetchRequest: FetchRequest<Reward>
    var rewards: FetchedResults<Reward> { fetchRequest.wrappedValue }
    
    init(index: Int, annual: Bool, month: Int, year: Int) {
        fetchRequest = FetchRequest<Reward>(entity: Reward.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Reward.redeemed, ascending: true),
                NSSortDescriptor(keyPath: \Reward.value, ascending: false),
                NSSortDescriptor(keyPath: \Reward.title, ascending: true)
            ],
            
            predicate: NSPredicate(format: "annual == \(annual) and month == \(month) and year == \(year)")
        )
        
        self.index = index
        self.annual = annual
        self.month = month
        self.year = year
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(getTextFromTag(tag: index))
                    .padding(20)
            }
            NavigationView {
                List {
                    ForEach(rewards) { reward in
                        ListRowView(reward: reward, title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value, redeemed: reward.redeemed)
                    }.onDelete(perform: deleteTasks)
                }
                .listStyle(DefaultListStyle())
                .navigationTitle("Monthly Rewards")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: NavigationLink("Add Monthly Reward", destination: AddRewardView(annual: annual))
                )
            }
        }
        .tag(index)
    }
    
    private func getTextFromTag(tag: Int) -> String {
        let month: Int = tag % 100
        let year: Int = tag / 100
        
        return "\(month)-\(year)"
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
            offsets.map { rewards[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListView(index: 202106, annual: true, month: 0, year: 2021)
        }
    }
}
