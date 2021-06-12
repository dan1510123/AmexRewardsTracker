//
//  ContentView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI
import CoreData

struct MRListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: MonthlyReward.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \MonthlyReward.redeemed, ascending: true),
        NSSortDescriptor(keyPath: \MonthlyReward.value, ascending: false),
        NSSortDescriptor(keyPath: \MonthlyReward.title, ascending: true)
    ])
    var monthlyRewards: FetchedResults<MonthlyReward>
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    
    
    var body: some View {
        TabView(selection: self.$index) {
            NavigationView {
                List {
                    ForEach(monthlyRewards) { reward in
                        MRListRowView(reward: reward, title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value, redeemed: reward.redeemed)
                    }.onDelete(perform: deleteTasks)
                }
                .listStyle(DefaultListStyle())
                .navigationTitle("Monthly Rewards")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: NavigationLink("Add Monthly Reward", destination: AddMRView())
                )
            }
            .tag(202105)
            VStack {
                Text(getTextFromTag(tag: index))
                NavigationView {
                    List {
                        ForEach(monthlyRewards) { reward in
                            MRListRowView(reward: reward, title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value, redeemed: reward.redeemed)
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
            .tag(202106)
            NavigationView {
                List {
                    ForEach(monthlyRewards) { reward in
                        MRListRowView(reward: reward, title: reward.title ?? "Untitled", details: reward.details ?? "", value: reward.value, redeemed: reward.redeemed)
                    }.onDelete(perform: deleteTasks)
                }
                .listStyle(DefaultListStyle())
                .navigationTitle("Monthly Rewards")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: NavigationLink("Add Monthly Reward", destination: AddMRView())
                )
            }
            .tag(202107)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
            offsets.map { monthlyRewards[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
}

struct MRListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MRListView()
        }
    }
}
