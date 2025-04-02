//
//  APIServices.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import Foundation

protocol ShapeFetching {
    func fetchShapes() async throws -> [ShapeButton]
}

struct APIService: ShapeFetching {
    func fetchShapes() async throws -> [ShapeButton] {
        guard let url = URL(string: "http://staticcontent.cricut.com/static/test/shapes_001.json") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        let cleanedJson = jsonString.removeTrailingCommas()
        
        guard let cleanedData = cleanedJson.data(using: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        let shapeResponse = try JSONDecoder().decode(ShapeResponse.self, from: cleanedData)
        
        return shapeResponse.buttons
    }
}

extension String {
    func removeTrailingCommas() -> String {
        let regex = try! NSRegularExpression(pattern: ",\\s*([}\\]])", options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1")
    }
}

