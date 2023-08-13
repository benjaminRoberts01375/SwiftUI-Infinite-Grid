// Created on 8/1/23 by Ben Roberts
// Created for the infinite grid library
//
// Swift 5.0
//

/*
 Copyright 2023 Benjamin Roberts
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
/// Object data for positioning view on a grid.
public struct GridObjectM: Identifiable {
    /// Conformance to identifiable.
    public var id: String
    /// Stored view to display.
    var content: AnyView
    public var pos: CGPoint
    
    /// Object data for positioning a view on a grid with binding controls.
    /// - Parameters:
    ///   - content: View to display.
    ///   - pos: Position on a grid.
    public init(content: any View, pos: CGPoint) {
        self.content = content
        self.pos = pos
    }
    
    /// Object data for positioning a view on a grid with binding controls.
    /// - Parameters:
    ///   - content: View to display.
    ///   - pos: Position on a grid.
    public init(content: any View, pos: CGSize) {
        self.init(content: content, pos: CGPoint(x: pos.width, y: pos.height))
    }
    
    /// A deprecated init for creating a grid object with a specific x and y coordinate.
    /// - Parameters:
    ///   - content: Content
    ///   - xPos: X Position on a grid.
    ///   - yPos: Y Position on a grid.
    @available(iOS, deprecated: 100000.0)
    @available(macOS, deprecated: 100000.0)
    @available(tvOS, deprecated: 100000.0)
    @available(macCatalyst, deprecated: 100000.0)
    public init(content: any View, xPos: CGFloat, yPos: CGFloat) {
        self.id = Mirror(reflecting: content).description // View hierarchy description
        self.init(content: content, pos: CGPoint(x: xPos, y: yPos))
    }
}
