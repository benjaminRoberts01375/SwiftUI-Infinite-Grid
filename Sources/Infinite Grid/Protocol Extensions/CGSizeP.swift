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

/// Protocol extensions for CGSize
extension CGSize {
    
    /// Allow for adding two CGSize objects together
    /// - Parameters:
    ///   - lhs: The first CGSIze on the left side of the plus symbol
    ///   - rhs: The second CGSize on the right of the plus symbol
    /// - Returns: A new CGSize with the combined values
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    /// Allow for adding two CGSize objects together via the plus equals symbol
    /// - Parameters:
    ///   - lhs: The first CGSIze on the left side of the plus equals symbol
    ///   - rhs: The second CGSize on the right of the plus equals symbol
    static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }
    
    /// Allow division of a CGSize with a CGFloat
    /// - Parameters:
    ///   - lhs: CGSize to divide
    ///   - rhs: CGFloat to divide with
    /// - Returns: A new CGSize that has been divided
    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
    
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    
    static func * (lhs: CGSize, rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width * rhs.x, height: lhs.height * rhs.y)
    }
    
}
