//
//  AnnualListView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/13/21.
//

import SwiftUI

struct AnnualListView: View {
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        ListView(index: index, annual: true, month: 0, year: currentYear, rewardType: "Annual")
    }
}

struct AnnualListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualListView()
    }
}
