//
//  ShapeButton.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import Foundation

struct ShapeResponse: Codable {
    let buttons: [ShapeButton]
}

// ShapeButton model representing the individual shape data
struct ShapeButton: Codable {
    let name: String
    let drawPath: String
    
    // Mapping the snake_case JSON field to the Swift property
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}
