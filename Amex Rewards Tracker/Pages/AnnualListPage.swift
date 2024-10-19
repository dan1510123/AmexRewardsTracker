//
//  AnnualListView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/13/21.
//

import SwiftUI
import CoreData

struct AnnualListPage: View {
    
    @State var index: Int = Calendar.current.component(.year, from: Date())  * 100 + Calendar.current.component(.month, from: Date())
    @State var adminMode: Bool = false
    @State var month: Int = 0
    @State var year: Int = Calendar.current.component(.year, from: Date())
    
    let buttonWidth: CGFloat = 30
    
    let viewContext: NSManagedObjectContext
    let annual = true
    
    var body: some View {
        VStack(alignment: .center) {
            NavigationView {
                ListView(index: index, annual: true, month: $month, year: $year, adminMode: $adminMode, viewContext: viewContext)
                    .navigationTitle("\(year) Annual Rewards".replacingOccurrences(of: ",", with: ""))
                    .navigationBarItems(
                        leading: getLeadingButton(),
                        trailing: getTrailingButton()
                    )
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            currentYearIndicator
                        }
                    }
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
        Group {
            if adminMode {
                EditButton()
            }
            else if year > 2020 {
                Button(action:  {
                    year = year - 1
                })
                {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(String(year - 1))
                    }
                }
                .frame(width: buttonWidth, alignment: .leading)
            }
        }
    }
    
    private func getTrailingButton() -> some View {
        Group {
            if adminMode {
                NavigationLink("Add Annual Reward", destination: AddRewardPage(annual: annual, rewardType: "Annual")).isDetailLink(false)
            }
            else {
                Button(action:  {
                    year = year + 1
                })
                {
                    HStack {
                        Text(String(year + 1))
                        Image(systemName: "chevron.right")
                    }
                }
                .frame(width: buttonWidth, alignment: .trailing)
            }
        }
    }
    
    private var currentYearIndicator: some View {
        Group {
            if year == Calendar.current.component(.year, from: Date()) && !self.adminMode {
                Text("Current")
                    .font(.body)
                    .padding(6) // Add padding around the text
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue) // Background color of the rounded rectangle
                    )
                    .foregroundColor(.white) // Text color
            }
        }
    }
}

struct AnnualListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnualListPage(year: 2024, viewContext: PersistenceController.preview.container.viewContext)
    }
}
