// Created on 7/27/23 by Ben Roberts
// Created for Noodle
//
// Swift 5.0
//

import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
extension InfiniteGridVMTests {
    func testNoTranslationSingle() {
        defaultGridObject.updateTranslation(newTranslation: .zero)
        XCTAssertEqual(defaultGridObject.sInteractionPoint, .zero)
    }
    
    func testNaNXTranslation() {
        let preTestTranslation = defaultGridObject.sTranslation.x
        defaultGridObject.updateTranslation(newTranslation: CGSize(width: CGFloat.nan, height: .zero))
        XCTAssertEqual(preTestTranslation, defaultGridObject.sTranslation.x)
    }
    
    func testNaNYTranslation() {
        let preTestTranslation = defaultGridObject.sTranslation.y
        defaultGridObject.updateTranslation(newTranslation: CGSize(width: .zero, height: CGFloat.nan))
        XCTAssertEqual(preTestTranslation, defaultGridObject.sTranslation.y)
    }
    
    func testSingleVerySmallPositiveXTranslation() {
        let amount: CGSize = CGSize(width: verySmallNum, height: .zero)
        defaultGridObject.updateTranslation(newTranslation: amount)
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(amount))
    }
    
    func testSequencePositiveXTranslation() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: num, height: .zero)) }
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(x: sequence.reduce(0, +), y: .zero))
    }
    
    func testSingleVerySmallNegativeXTranslation() {
        let amount: CGSize = CGSize(width: -verySmallNum, height: .zero)
        defaultGridObject.updateTranslation(newTranslation: amount)
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(amount))
    }
    
    func testSequenceNegativeXTranslation() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: -num, height: .zero)) }
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(x: sequence.reduce(0, -), y: .zero))
    }
    
    func testSequencePositiveXAndBack() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: num, height: .zero)) }
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: -num, height: .zero)) }
        XCTAssertEqual(defaultGridObject.sTranslation, .zero)
    }
    
    func testSingleVerySmallPositiveYTranslation() {
        let amount: CGSize = CGSize(width: .zero, height: verySmallNum)
        defaultGridObject.updateTranslation(newTranslation: amount)
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(amount))
    }
    
    func testSequencePositiveYTranslation() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: .zero, height: num)) }
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(x: .zero, y: sequence.reduce(0, +)))
    }
    
    func testSingleVerySmallNegativeYTranslation() {
        let amount: CGSize = CGSize(width: .zero, height: -verySmallNum)
        defaultGridObject.updateTranslation(newTranslation: amount)
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(amount))
    }
    
    func testSequenceNegativeYTranslation() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: .zero, height: -num)) }
        XCTAssertEqual(defaultGridObject.sTranslation, CGPoint(x: .zero, y: sequence.reduce(0, -)))
    }
    
    func testSequencePositiveYAndBack() {
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: .zero, height: num)) }
        for num in sequence { defaultGridObject.updateTranslation(newTranslation: CGSize(width: .zero, height: -num)) }
        XCTAssertEqual(defaultGridObject.sTranslation, .zero)
    }
}
