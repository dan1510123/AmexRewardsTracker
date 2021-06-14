//
//  AnnualListView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/13/21.
//

import SwiftUI

struct AnnualListView: View {
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    @State var adminMode: Bool = false
    
    let annual = true
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        NavigationView {
            ListView(index: index, annual: true, month: 0, year: currentYear)
                .navigationTitle("Annual Rewards")
                .navigationBarItems(
                    leading: getLeadingButton(),
                    trailing: getTrailingButton()
                )
        }
    }
    
    private func getLeadingButton() -> some View {
        if(adminMode) {
            return AnyView(EditButton())
        }
        else {
            return AnyView(Text(""))
        }
    }
    
    private func getTrailingButton() -> some View {
        if(adminMode) {
            return AnyView(NavigationLink("Add Annual Reward", destination: AddRewardView(annual: annual, rewardType: "Annual")).isDetailLink(false))
        }
        else {
            return AnyView(Text(""))
        }
    }
}

struct AnnualListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualListView()
    }
}
