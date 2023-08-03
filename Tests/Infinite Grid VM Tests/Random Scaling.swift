// Created on 7/27/23 by Ben Roberts
// Created for the infinite grid library
//
// Swift 5.0
//

import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func testSingleOffCenterScale() {
        defaultGridObject.setScreenSize(CGSize(width: veryLargeNum, height: veryLargeNum))
        defaultGridObject.updateScale(newScale: 2, sInteractionPoint: CGPoint(x: veryLargeNum / 2, y: veryLargeNum / 2))
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(x: veryLargeNum / -4, y: veryLargeNum / -4))
    }
    func testSequenceOffCenterScale() {
        defaultGridObject.setScreenSize(CGSize(width: veryLargeNum, height: veryLargeNum))
        for (i, num) in sequence.enumerated() where i > 1 {
            defaultGridObject.updateScale(newScale: num, sInteractionPoint: CGPoint(x: veryLargeNum / 2, y: veryLargeNum / 2))
        }
        XCTAssertEqual(CGPoint(x: floor(defaultGridObject.sTranslation.x), y: floor(defaultGridObject.sTranslation.y)), CGPoint(x: veryLargeNum / -2, y: veryLargeNum / -2)) // rounded to remove insignificant floating point error
    }
}
