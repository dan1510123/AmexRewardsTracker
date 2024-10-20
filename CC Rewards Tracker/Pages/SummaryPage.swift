//
//  SummaryView.swift
//  Credit Card Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI
import CoreData

struct SummaryPage: View {
    
    @Binding var adminMode: Bool
    
    let viewContext: NSManagedObjectContext
    @State var year: Int = Calendar.current.component(.year, from: Date())
    
    init(viewContext: NSManagedObjectContext, adminMode: Binding<Bool>) {
        self.viewContext = viewContext
        self._adminMode = adminMode
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ProgressTileView(rewardType: "Total",
                                     year: year)
                    ProgressTileView(rewardType: "Platinum",
                                     year: year)
                    ProgressTileView(rewardType: "Gold",
                                     year: year)
                    ProgressTileView(rewardType: "Delta Reserve",
                                     year: year)
                    
                }
                .navigationTitle("\(year) Rewards".replacingOccurrences(of: ",", with: ""))
                .navigationBarItems(
                    leading: getLeadingButton(),
                    trailing: getTrailingButton()
                )
            }
            .background(Color.white)
            
            if adminMode {
                Button(action: {
                    self.adminMode.toggle()
                }) {
                    Text("LEAVE ADMIN MODE")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.9386306405, green: 0, blue: 0, alpha: 1)))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 10)
            }
        }
    }
    
    private func getLeadingButton() -> some View {
        Button(action:  {
            year = year - 1
        })
        {
            HStack {
                Image(systemName: "chevron.left")
                Text(String(year - 1) + " Summary")
            }
        }
        .frame(alignment: .leading)
    }
    
    private func getTrailingButton() -> some View {
        Button(action:  {
            year = year + 1
        })
        {
            HStack {
                Text(String(year + 1) + " Summary")
                Image(systemName: "chevron.right")
            }
        }
        .frame(alignment: .leading)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")//SummaryView()
    }
}
