//
//  ShapesGridAppTests.swift
//  ShapesGridAppTests
//
//  Created by Dean Wagstaff on 3/31/25.
//

import XCTest
@testable import ShapesGridApp

final class ShapesViewModelTests: XCTestCase {

    func testAddShapeAppendsShape() {
        let viewModel = ShapesViewModel()
        viewModel.addShape("circle")
        viewModel.addShape("square")
        XCTAssertEqual(viewModel.shapes, ["circle", "square"])
    }

    func testClearAllShapesRemovesAll() {
        let viewModel = ShapesViewModel()
        viewModel.shapes = ["circle", "square", "triangle"]
        viewModel.clearAllShapes()
        XCTAssertTrue(viewModel.shapes.isEmpty)
    }

    func testRemoveAllCircles() {
        let viewModel = ShapesViewModel()
        viewModel.shapes = ["circle", "square", "circle", "triangle"]
        viewModel.shapes.removeAll { $0 == "circle" }
        XCTAssertEqual(viewModel.shapes, ["square", "triangle"])
    }

    func testRemoveLastCircle() {
        let viewModel = ShapesViewModel()
        viewModel.shapes = ["circle", "square", "circle", "triangle"]
        if let index = viewModel.shapes.lastIndex(of: "circle") {
            viewModel.shapes.remove(at: index)
        }
        XCTAssertEqual(viewModel.shapes, ["circle", "square", "triangle"])
    }

    func testFetchButtonsLoadsShapeButtons() async {
        let viewModel = ShapesViewModel(apiService: MockAPIService())
        await viewModel.fetchButtons()
        XCTAssertEqual(viewModel.buttons.count, 2)
    }

    func testFetchButtonsHandlesError() async {
        let viewModel = ShapesViewModel(apiService: FailingAPIService())
        await viewModel.fetchButtons()
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

// MARK: - Test Mocks

struct MockAPIService: ShapeFetching {
    func fetchShapes() async throws -> [ShapeButton] {
        [
            ShapeButton(name: "Circle", drawPath: "circle"),
            ShapeButton(name: "Square", drawPath: "square")
        ]
    }
}

struct FailingAPIService: ShapeFetching {
    func fetchShapes() async throws -> [ShapeButton] {
        throw URLError(.notConnectedToInternet)
    }
}

