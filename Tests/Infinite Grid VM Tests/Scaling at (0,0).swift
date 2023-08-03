// Created on 7/27/23 by Ben Roberts
// Created for the infinite grid library
//
// Swift 5.0
//

import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func testZeroScale() {
        defaultGridObject.updateScale(newScale: 0, sInteractionPoint: .zero)
        XCTAssertEqual(defaultGridObject.gScale, defaultGridObject.smallestAllowedLineGap / defaultGridObject.sLineSpacing) // Scale cancels out
    }
    
    func testNaNScale() {
        let scalePreTest = defaultGridObject.gScale
        defaultGridObject.updateScale(newScale: CGFloat.nan, sInteractionPoint: .zero)
        XCTAssertEqual(defaultGridObject.gScale, scalePreTest)
    }
    
    func testInfiniteScale() {
        let scalePreTest = defaultGridObject.gScale
        defaultGridObject.updateScale(newScale: CGFloat.infinity, sInteractionPoint: .zero)
        XCTAssertEqual(defaultGridObject.gScale, scalePreTest)
    }
    
    func testNegativeScale() {
        defaultGridObject.updateScale(newScale: -5, sInteractionPoint: .zero)
        XCTAssertEqual(defaultGridObject.gScale, defaultGridObject.smallestAllowedLineGap / defaultGridObject.sLineSpacing) // Scale cancels out
    }

    func testSingleVerySmallCenterScale() {
        defaultGridObject.updateScale(newScale: verySmallNum, sInteractionPoint: .zero)
        XCTAssertEqual(defaultGridObject.gScale, defaultGridObject.smallestAllowedLineGap / defaultGridObject.sLineSpacing)
    }
    
    func testSequenceCenterScale() {
        for (i, num) in sequence.enumerated() where i > 0 { // Skip the smallest number since it's too small
            defaultGridObject.updateScale(newScale: num, sInteractionPoint: .zero)
        }
        XCTAssertEqual(defaultGridObject.gScale, 4000) // Should hit max scale
    }
    
    func testSequenceCenterScaleAndBack() {
        for (i, num) in sequence.enumerated() where i > 0 { // Skip the smallest number since it's too small
            defaultGridObject.updateScale(newScale: num, sInteractionPoint: .zero)
        }
        
        for (i, num) in sequence.enumerated() where i > 0 { // Skip the smallest number since it's too small
            defaultGridObject.updateScale(newScale: 1 / num, sInteractionPoint: .zero)
        }
        XCTAssertEqual(round(defaultGridObject.gScale * 100) / 100, 0.04) // Should hit min scale
    }
}
