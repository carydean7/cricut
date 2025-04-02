//
//  ShapesGridView.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import SwiftUI

struct ShapesGridView: View {
    @StateObject private var viewModel = ShapesViewModel()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Grid to Display Shapes
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(Array(viewModel.shapes.enumerated()), id: \.offset) { index, shape in
                            ShapeView(shape: shape)
                        }
                    }
                    
                    Spacer()
                    
                    // Dynamic Shape Buttons
                    HStack {
                        ForEach(viewModel.buttons, id: \.name) { button in
                            Button(button.name) {
                                viewModel.addShape(button.drawPath)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.bottom)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .toolbar {
                    // Clear All Button on Left
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear All") {
                            viewModel.clearAllShapes()
                        }
                    }
                    
                    // Edit Circles Button on Right, Navigating to ShapesView
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("Edit Circles") {
                            EditCirclesView(viewModel: viewModel)
                        }
                    }
                }
                .task {
                    await viewModel.fetchButtons()
                }
                .alert("Error", isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.clearError() } }
                )) {
                    Button("OK", role: .cancel) {
                        viewModel.clearError()
                    }
                } message: {
                    Text(viewModel.errorMessage ?? "Unknown error")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    ShapesGridView()
}
