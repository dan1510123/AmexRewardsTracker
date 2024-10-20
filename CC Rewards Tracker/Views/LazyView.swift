//
//  LazyView.swift
//  Amex Rewards Tracker
//
//  Created by Daniel Luo on 10/19/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
