// Created on 7/27/23 by Ben Roberts
// Created for the infinite grid library
//
// Swift 5.0
//

import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func testSettingScreenSize() {
        let amount = CGSize(width: veryLargeNum, height: veryLargeNum)
        defaultGridObject.setScreenSize(amount)
        XCTAssertEqual(defaultGridObject.sSize, amount)
    }
    
    func testNanWidthScreenSize() {
        let preTest = defaultGridObject.sSize.width
        defaultGridObject.setScreenSize(CGSize(width: CGFloat.nan, height: veryLargeNum))
        XCTAssertEqual(preTest, defaultGridObject.sSize.width)
    }
    
    func testNanHeightScreenSize() {
        let preTest = defaultGridObject.sSize.height
        defaultGridObject.setScreenSize(CGSize(width: veryLargeNum, height: CGFloat.nan))
        XCTAssertEqual(preTest, defaultGridObject.sSize.height)
    }
}
