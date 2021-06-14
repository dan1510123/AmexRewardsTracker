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
    @State var month: Int = 0
    @State var year: Int = Calendar.current.component(.year, from: Date())
    
    let annual = true
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationView {
                ListView(index: index, annual: true, month: $month, year: $year, adminMode: $adminMode)
                    .navigationTitle("Annual Rewards")
                    .navigationBarItems(
                        leading: getLeadingButton(),
                        trailing: getTrailingButton()
                    )
            }
            Button(action: {
                self.adminMode = !self.adminMode
            }) {
                Text("ADMIN MODE")
                    .font(.system(size: 20.0, design: .monospaced))
                    .foregroundColor(.white)
            }
            .frame(width: 160, height: 60)
            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
            .cornerRadius(50)
            .padding(.bottom, 10)
        }
        .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)))
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
