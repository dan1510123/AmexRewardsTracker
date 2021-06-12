//
//  MRListPagesView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/12/21.
//

import SwiftUI

struct MRListPagesView: View {
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    
    let currentYear: Int = Calendar.current.component(.year, from: Date())
    let currentMonth: Int = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        ListView(index: index, annual: false, month: currentMonth, year: currentYear)
    }
}

struct MRListPagesView_Previews: PreviewProvider {
    static var previews: some View {
        MRListPagesView()
    }
}
