import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/wagstaffd/Desktop/ShapesGridApp/ShapesGridApp/Views/ShapeView.swift", line: 1)
//
//  ShapeView.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import SwiftUI

struct ShapeView: View {
    let shape: String
    
    var body: some View {
        switch shape {
        case "circle":
            Circle()
                .fill(Color(red: __designTimeInteger("#4270_0", fallback: 89)/__designTimeInteger("#4270_1", fallback: 255), green: __designTimeInteger("#4270_2", fallback: 174)/__designTimeInteger("#4270_3", fallback: 255), blue: __designTimeInteger("#4270_4", fallback: 196)/__designTimeInteger("#4270_5", fallback: 255)))
                .frame(width: __designTimeInteger("#4270_6", fallback: 50), height: __designTimeInteger("#4270_7", fallback: 50))
            
        case "square":
            Rectangle()
                .fill(Color(red: __designTimeInteger("#4270_8", fallback: 89)/__designTimeInteger("#4270_9", fallback: 255), green: __designTimeInteger("#4270_10", fallback: 174)/__designTimeInteger("#4270_11", fallback: 255), blue: __designTimeInteger("#4270_12", fallback: 196)/__designTimeInteger("#4270_13", fallback: 255)))
                .frame(width: __designTimeInteger("#4270_14", fallback: 50), height: __designTimeInteger("#4270_15", fallback: 50))

        case "triangle":
            TriangleView().frame(width: __designTimeInteger("#4270_16", fallback: 50), height: __designTimeInteger("#4270_17", fallback: 50))
        default:
            EmptyView()
        }
    }
}

// Simple Triangle Shape
struct TriangleView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: __designTimeInteger("#4270_18", fallback: 25), y: __designTimeInteger("#4270_19", fallback: 0)))
            path.addLine(to: CGPoint(x: __designTimeInteger("#4270_20", fallback: 0), y: __designTimeInteger("#4270_21", fallback: 50)))
            path.addLine(to: CGPoint(x: __designTimeInteger("#4270_22", fallback: 50), y: __designTimeInteger("#4270_23", fallback: 50)))
            path.closeSubpath()
        }
        .fill(Color(red: __designTimeInteger("#4270_24", fallback: 89)/__designTimeInteger("#4270_25", fallback: 255), green: __designTimeInteger("#4270_26", fallback: 174)/__designTimeInteger("#4270_27", fallback: 255), blue: __designTimeInteger("#4270_28", fallback: 196)/__designTimeInteger("#4270_29", fallback: 255)))
    }
}

#Preview {
    ShapeView(shape: __designTimeString("#4270_30", fallback: "Circle"))
}
