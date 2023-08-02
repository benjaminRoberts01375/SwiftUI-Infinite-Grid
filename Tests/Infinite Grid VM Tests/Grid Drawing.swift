// Created on 7/28/23 by Ben Roberts
// Created for Noodle
//
// Swift 5.0
//

import SwiftUI
import XCTest
@testable import Infinite_Grid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func drawGrid(sTranslation: CGPoint = .zero, gScale: CGFloat = 1) -> Path {
        return drawGrid(sTranslation: sTranslation, gScale: gScale, sSize: defaultScreenSize)
    }
    
    func drawGrid(sTranslation: CGPoint = .zero, gScale: CGFloat = 1, sSize: CGSize) -> Path {
        /// Grid to modify and return.
        var path: Path = Path()
        
        // Vertical lines
        var pos: CGFloat = (sTranslation.x - floor(sTranslation.x / defaultGridObject.sLineSpacing) * defaultGridObject.sLineSpacing) * gScale
        while pos < sSize.width {
            path.move(to: CGPoint(x: pos, y: .zero))
            path.addLine(to: CGPoint(x: pos, y: sSize.height))
            pos += defaultGridObject.sLineSpacing * gScale
        }
        
        // Horizontal lines
        pos = (sTranslation.y - floor(sTranslation.y / defaultGridObject.sLineSpacing) * defaultGridObject.sLineSpacing) * gScale
        while pos < sSize.height {
            path.move(to: CGPoint(x: .zero, y: pos))
            path.addLine(to: CGPoint(x: sSize.width, y: pos))
            pos += defaultGridObject.sLineSpacing * gScale
        }
        
        return path
    }
    
    func testDrawDefaultGrid() {
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid()
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testGridWrapping() {
        defaultGridObject.updateTranslation(newTranslation: CGSize(width: defaultGridObject.sLineSpacing, height: defaultGridObject.sLineSpacing))
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid()
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testGenericTranslation() {
        defaultGridObject.updateTranslation(newTranslation: CGSize(width: mediumNum, height: largeNum))
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid(sTranslation: CGPoint(x: mediumNum, y: largeNum))
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testActualGridSize() {
        let path = defaultGridObject.drawGrid()
        XCTAssertEqual(path.cgPath.boundingBox, CGRect(x: 0, y: 0, width: defaultScreenSize.width, height: defaultScreenSize.height))
    }
    
    func testScaleAtZero() {
        defaultGridObject.updateScale(newScale: 2, sInteractionPoint: .zero)
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid(gScale: 2)
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testScaleMidNoTranslation() {
        defaultGridObject.updateScale(newScale: 2, sInteractionPoint: CGPoint(x: defaultScreenSize.width / 2, y: defaultScreenSize.height / 2))
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid(sTranslation: CGPoint(x: defaultScreenSize.width / 4, y: defaultScreenSize.height / 4), gScale: 2)
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testScaleMidWithTranslation() {
        let translation = CGSize(width: veryLargeNum, height: veryLargeNum)
        defaultGridObject.updateTranslation(newTranslation: translation)
        defaultGridObject.updateScale(newScale: mediumNum, sInteractionPoint: CGPoint(x: defaultScreenSize.width / 2, y: defaultScreenSize.height / 2))
        let path = defaultGridObject.drawGrid()
        let expectedPath = drawGrid(sTranslation: CGPoint(x: translation.width + defaultScreenSize.width / (2 * mediumNum), y: translation.height + defaultScreenSize.height / (2 * mediumNum)), gScale: mediumNum)
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testForceZeroScale() {
        var translation: CGPoint = .zero
        var interactionPoint: CGPoint = .zero
        let gridObject = InfiniteCanvasVM(
            baseScale: 1,
            smallestAllowedLineGap: 1,
            largestAllowedLineGap: 100000,
            translation: Binding<CGPoint>(get: { translation }, set: { translation = $0 }),
            scale: .constant(.zero),
            interactionPoint: Binding<CGPoint>(get: { interactionPoint }, set: { interactionPoint = $0 })
        )
        gridObject.setScreenSize(defaultScreenSize)
        let path = gridObject.drawGrid()
        let expectedPath = Path()
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
    
    func testForceZeroTranslation() {
        var scale: CGFloat = 1
        var interactionPoint: CGPoint = CGPoint(x: defaultScreenSize.width / 2, y: defaultScreenSize.height / 2)
        let gridObject = InfiniteCanvasVM(
            baseScale: 1,
            smallestAllowedLineGap: 1,
            largestAllowedLineGap: 100000,
            translation: .constant(.zero),
            scale: Binding<CGFloat>(get: { scale }, set: { scale = $0 }),
            interactionPoint: Binding<CGPoint>(get: { interactionPoint }, set: { interactionPoint = $0 })
        )
        gridObject.setScreenSize(defaultScreenSize)
        gridObject.updateScale(newScale: 2, sInteractionPoint: interactionPoint)
        let path = gridObject.drawGrid()
        let expectedPath = drawGrid(sTranslation: .zero, gScale: 2)
        XCTAssertEqual(path, expectedPath, "\nGenerated: \(path)\nExpected:  \(expectedPath)")
    }
}
