//
//  ContentView.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ShapesGridView()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ShapesGridView()
}
