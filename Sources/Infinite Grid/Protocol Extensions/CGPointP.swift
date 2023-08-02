// Created on 8/1/23 by Ben Roberts
// Created for the infinite canvas library
//
// Swift 5.0
//

import SwiftUI

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

extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Allow subtraction of a CGPoint with another CGPoint
    /// - Parameters:
    ///   - lhs: Minuend
    ///   - rhs: Subtrahend
    /// - Returns: A new CGPoint that has been subtracted
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }
    
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    static func / (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x / rhs.width, y: lhs.y / rhs.height)
    }
    
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += lhs.y
    }
    
    static func += (lhs: inout CGPoint, rhs: CGSize) {
        lhs.x += rhs.width
        lhs.y += rhs.height
    }
    
    static func -= (lhs: inout CGPoint, rhs: CGSize) {
        lhs.x -= rhs.width
        lhs.y -= rhs.height
    }
    
    init (_ value: CGSize) {
        self.init(x: value.width, y: value.height)
    }
}
