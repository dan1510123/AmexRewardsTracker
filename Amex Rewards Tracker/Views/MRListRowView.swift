//
//  MRListRowView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/11/21.
//

import SwiftUI

struct MRListRowView: View {
    
    let title: String
    let details: String
    let value: Double
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle")
                Text(title)
                Spacer()
                Text("\(String(format: "%.2f", value))")
            }
            HStack {
                Text(details)
            }
        }
    }
}

struct MRListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MRListRowView(title: "item", details: "deets", value: 100)
    }
}
