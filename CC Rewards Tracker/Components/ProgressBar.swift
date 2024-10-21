//
//  ProgressBar.swift
//  Credit Card Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI

struct ProgressBar: View {
    let barColor: Color
    let progress: Float
    let goal: Float
    
    init(progressPercent: Float, goalPercent: Float, color: Color) {
        self.progress = progressPercent
        self.goal = goalPercent
        self.barColor = color
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Bar
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.barColor.opacity(0.7))
                
                // Progress Bar
                Rectangle()
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(self.barColor)
                
                // Goal Marker
                let goalPosition = CGFloat(self.goal) * geometry.size.width
                Rectangle()
                    .frame(width: 2, height: geometry.size.height)
                    .foregroundColor(.red)
                    .offset(x: goalPosition - 1, y: 0)
            }
            .cornerRadius(45.0)
        }
        .frame(height: 20) // Set a height for the progress bar
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progressPercent: 0.6, goalPercent: 0.8, color: Color.blue)
    }
}
