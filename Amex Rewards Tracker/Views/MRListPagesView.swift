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
    var months: Array<Month>
    
    struct Month: Identifiable {
        let id = UUID()
        let value: Int
    }
    
    init() {
        self.months = Array()
        for month in 1...12 {
            self.months.append(Month(value: month))
        }
    }
    
    var body: some View {
        TabView(selection: self.$index) {
            ForEach(months) { month in
                ListView(index: currentYear * 100 + Int(month.value), annual: false, month: Int(month.value))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct MRListPagesView_Previews: PreviewProvider {
    static var previews: some View {
        MRListPagesView()
    }
}
