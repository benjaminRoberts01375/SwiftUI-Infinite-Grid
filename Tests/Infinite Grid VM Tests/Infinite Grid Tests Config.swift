// Created on 5/24/23 by Ben Roberts
// Created for Noodle
//
// Swift 5.0
//

import SwiftUI
import XCTest
@testable import InfiniteGrid

@available(macOS 14.0, *)
final class InfiniteGridVMTests: XCTestCase {
    public var defaultGridObject: InfiniteCanvasVM!
    var translation: CGPoint!
    var scale: CGFloat!
    var interactionPoint: CGPoint!
    
    let sequence: [Double] = [0.001, 1.01, 10, 100, 1000]
    var verySmallNum: Double { get { sequence[0] } }
    var smallNum: Double { get { sequence[1] } }
    var mediumNum: Double { get { sequence[2] } }
    var largeNum: Double { get { sequence[3] } }
    var veryLargeNum: Double { get { sequence[4] } }
    var defaultScreenSize: CGSize { get { CGSize(width: veryLargeNum, height: veryLargeNum)}}
    
    override func setUpWithError() throws {
        translation = .zero
        scale = 1
        interactionPoint = .zero
        defaultGridObject = InfiniteCanvasVM(
            baseScale: 1,
            smallestAllowedLineGap: 1,
            largestAllowedLineGap: 100000,
            translation: Binding<CGPoint>(get: { self.translation }, set: { self.translation = $0 }),
            scale: Binding<CGFloat>(get: { self.scale }, set: { self.scale = $0 }),
            interactionPoint: Binding<CGPoint>(get: { self.interactionPoint }, set: { self.interactionPoint = $0 })
        )
        defaultGridObject.setScreenSize(defaultScreenSize)
    }

    override func tearDownWithError() throws {
        defaultGridObject = nil
    }
}
