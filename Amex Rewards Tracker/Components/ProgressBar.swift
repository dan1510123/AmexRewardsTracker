//
//  ProgressBar.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 6/14/21.
//

import SwiftUI

struct ProgressBar: View {
    let barColor: Color
    var value: Float
    
    init(value: Float, color: Color) {
        self.barColor = color
        self.value = value
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
