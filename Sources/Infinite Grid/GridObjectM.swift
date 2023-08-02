// Created on 8/1/23 by Ben Roberts
// Created for the infinite canvas library
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
    public let id = UUID()
    /// Stored view to display.
    var content: AnyView
    /// X position for the content on a grid in grid-space.
    @Binding var xPos: CGFloat
    /// Y position for the content on a grid in grid-space.
    @Binding var yPos: CGFloat
    
    /// Object data for positioning a view on a grid with binding controls.
    /// - Parameters:
    ///   - content: View to display.
    ///   - xPos: Binding for the X position on a grid.
    ///   - yPos: Binding for the Y position on a grid.
    init(content: any View, xPos: Binding<CGFloat>, yPos: Binding<CGFloat>) {
        self.content = AnyView(content)
        self._xPos = xPos
        self._yPos = yPos
    }
    
    /// Object data for positioning a view on a grid with binding controls.
    /// - Parameters:
    ///   - content: View to display.
    ///   - xPos: X position on a grid.
    ///   - yPos: Y position on a grid.
    init(content: any View, xPos: CGFloat, yPos: CGFloat) {
        self.content = AnyView(content)
        self._xPos = .constant(xPos)
        self._yPos = .constant(yPos)
    }
}
