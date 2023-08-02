// Created on 7/27/23 by Ben Roberts
// Created for Noodle
//
// Swift 5.0
//

import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func testInitialPosition() {
        XCTAssertEqual(defaultGridObject.sTranslation, .zero)
    }
    
    func testInitialScale() {
        XCTAssertEqual(defaultGridObject.gScale, 1)
    }
    
    func testInitialInteractionPoint() {
        XCTAssertEqual(defaultGridObject.sInteractionPoint, .zero)
    }
}
