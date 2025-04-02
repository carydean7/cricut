//
//  ShapesViewModel.swift
//  ShapesGridApp
//
//  Created by Dean Wagstaff on 3/31/25.
//

import Foundation

class ShapesViewModel: ObservableObject {
    @Published var buttons: [ShapeButton] = []
    @Published var shapes: [String] = []
    @Published var errorMessage: String? = nil

    private let apiService: ShapeFetching
    
    init(apiService: ShapeFetching = APIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchButtons() async {
        let localService = apiService
        let setButtons: ([ShapeButton]) -> Void = { self.buttons = $0 }
        let setError: (String) -> Void = { self.errorMessage = $0 }

        do {
            let data = try await localService.fetchShapes()
            setButtons(data)
        } catch {
            setError(error.localizedDescription)
        }
    }

    func clearError() {
        errorMessage = nil
    }
    
    func addShape(_ shape: String) {
        shapes.append(shape)
    }
    
    func clearAllShapes() {
        shapes.removeAll()
    }
}

struct MockAPIService: ShapeFetching {
    func fetchShapes() async throws -> [ShapeButton] {
        return [
            ShapeButton(name: "Circle", drawPath: "circle"),
            ShapeButton(name: "Square", drawPath: "square")
        ]
    }
}

