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
                .fill(Color(red: 89/255, green: 174/255, blue: 196/255))
                .frame(width: 50, height: 50)
            
        case "square":
            Rectangle()
                .fill(Color(red: 89/255, green: 174/255, blue: 196/255))
                .frame(width: 50, height: 50)

        case "triangle":
            TriangleView().frame(width: 50, height: 50)
        default:
            EmptyView()
        }
    }
}

// Simple Triangle Shape
struct TriangleView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 25, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 50))
            path.addLine(to: CGPoint(x: 50, y: 50))
            path.closeSubpath()
        }
        .fill(Color(red: 89/255, green: 174/255, blue: 196/255))
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ShapeView(shape: "Circle")
}
