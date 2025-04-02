//
//  EditCirclesView.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import SwiftUI

struct EditCirclesView: View {
    @ObservedObject var viewModel: ShapesViewModel
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                
                let circles = viewModel.shapes.filter { $0 == "circle" }
                
                ForEach(Array(circles.enumerated()), id: \.offset) { _, _ in
                    Circle()
                        .fill(Color(red: 89/255, green: 174/255, blue: 196/255))
                        .frame(width: 50, height: 50)
                }
            }
            
            Spacer()
            
            HStack {
                Button("Delete All") {
                    viewModel.shapes.removeAll { $0 == "circle" }
                }
                
                Button("Add Circle") {
                    viewModel.addShape("circle")
                }
                
                Button("Remove Circle") {
                    if let index = viewModel.shapes.lastIndex(of: "circle") {
                        viewModel.shapes.remove(at: index)
                    }
                }
            }
        }
    }
}
#Preview {
    EditCirclesView(viewModel: ShapesViewModel())
}
