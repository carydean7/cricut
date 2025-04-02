//
//  ShapesView.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 4/1/25.
//

import SwiftUI

struct ShapesView: View {
    @ObservedObject var viewModel: ShapesViewModel
    
    @State private var shapes: [String] = []
    @State private var shapeButtons: [ShapeButton] = []
    
    var body: some View {
        NavigationView {
            VStack {
                // Grid of shapes
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                        ForEach(Array(viewModel.shapes.enumerated()), id: \.offset) { _, shape in
                            ShapeView(shape: shape)
                        }
                    }
                }
                
                Spacer()
                
                // Dynamic buttons at the bottom
                HStack {
                    ForEach(shapeButtons, id: \.name) { button in
                        Button(button.name) {
                            shapes.append(button.drawPath)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
            .toolbar {
                // Clear All Button on Left
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All") {
                        shapes.removeAll()
                    }
                }
            }
            .task {
                await fetchShapes()
            }
        }
    }
    
    // Fetch ShapeButtons from API
    @MainActor
    func fetchShapes() async {
        do {
            let buttons = try await APIService().fetchShapes()
            self.shapeButtons = buttons
        } catch {
            print("Failed to fetch shapes: \(error)")
        }
    }

//    func fetchShapes() {
//        APIService().fetchShapes { result in
//            switch result {
//            case .success(let buttons):
//                DispatchQueue.main.async {
//                    self.shapeButtons = buttons
//                }
//            case .failure(let error):
//                print("Failed to fetch shapes: \(error)")
//            }
//        }
//    }
}

#Preview {
    ShapesView(viewModel: ShapesViewModel())
}
