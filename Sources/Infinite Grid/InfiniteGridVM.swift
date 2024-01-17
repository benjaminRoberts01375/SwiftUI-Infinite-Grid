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
/// Initializer for the InfiniteCanvas view model, which handles translation, scaling, screen size, and creating the path for the grid.
@Observable
public final class InfiniteGridVM {
    /// The perceived scale of the grid.
    private(set) var gScale: CGFloat
    /// Position to perform scale calculations from. Typically at the position of a `magnifyGesture()`.
    private(set) var sInteractionPoint: CGPoint
    /// Size of the canvas which to draw the grid on.
    private(set) var sSize: CGSize = .zero
    /// The perceived translation of the grid.
    /// - Important: This is not the "camera's" position, this is how the grid has been slid, thus, the values may be the inverse of what is expected.
    private(set) var sTranslation: CGPoint
    /// Spacing between lines at a 1.0 scale.
    public let sLineSpacing: CGFloat
    /// Smallest allowed gap between lines measured in points.
    public let smallestAllowedLineGap: CGFloat
    /// Largest allowed gap between lines measured in points.
    public let largestAllowedLineGap: CGFloat

    /// Initializer for the InfiniteCanvas view model, which handles translation, scaling, screen size, and creating the path for the grid.
    /// - Parameters:
    ///   - baseScale: Scale offset. Helpful for when multiple grids are overlaid with eachother.
    ///   - smallestAllowedLineGap: The smallest allowed gap between lines in points. This dictates the smallest allowed scale.
    ///   - largestAllowedLineGap: The largest allowed gap between lines in points. This dictates the largest allowed scale.
    ///   - translation: Binding for the translation OF THE GRID, not the camera.
    ///   - scale: Binding for the scale of the grid.
    ///   - interactionPoint: Binding for the scale interaction point.
    init(baseScale: CGFloat = 1, smallestAllowedLineGap: CGFloat, largestAllowedLineGap: CGFloat, translation: CGPoint, scale: CGFloat, interactionPoint: CGPoint) {
        self.sSize = .zero
        self.gScale = scale
        self.sTranslation = translation
        self.sInteractionPoint = interactionPoint
        self.sLineSpacing = 25 * baseScale
        self.smallestAllowedLineGap = smallestAllowedLineGap
        self.largestAllowedLineGap = largestAllowedLineGap
    }

    /// Adds to the current translation of the grid.
    /// - Parameter sTranslation: Amount to translate
    public func updateTranslation(newTranslation sTranslation: CGSize) {
        if !(sTranslation.width.isFinite && sTranslation.height.isFinite) {
            return
        }
        self.sTranslation += sTranslation / gScale
    }
    
    /// Multiplies the current scale by the provided scale, and updates the translation accordingly.
    /// - Parameters:
    ///   - inputScaleMultiplier: The raw input for multiplying the scale
    ///   - sInteractionPoint: Position of the interaction
    public func updateScale(newScale inputScaleMultiplier: CGFloat, sInteractionPoint: CGPoint) {
        if !inputScaleMultiplier.isFinite {
            return
        }
        var scaleMultiplier = inputScaleMultiplier
        if gScale * scaleMultiplier * sLineSpacing < smallestAllowedLineGap {
            scaleMultiplier = smallestAllowedLineGap / (gScale * sLineSpacing)
        }
        else if gScale * scaleMultiplier * sLineSpacing > largestAllowedLineGap {
            scaleMultiplier = largestAllowedLineGap / (gScale * sLineSpacing)
        }

        /* Process:
         1. Determine how far inward the gesture occured in a 0-1 scale (interaction proportion)
         2. Determine number of grid points displayed on screen in previous frame
         3. Determine number of grid point displayed on screen in current frame
         4. Determine the delta
         5. Determine how many grid points were "pushed" left and up via the interaction proportion.
         6. Add this value to the existing translation, update the scale value, and save the newest interaction point.
         */
            
        let oldInteractionProportion = sInteractionPoint / sSize
        if !(oldInteractionProportion.x.isFinite && oldInteractionProportion.y.isFinite) {
            return
        }
        let oldDisplayedGridPoints = sSize / gScale
        let newDisplayedGridPoints = sSize / (gScale * scaleMultiplier)
        let deltaDisplayedGridPoints = newDisplayedGridPoints - oldDisplayedGridPoints
        let displacedTopLeftGridPoints = deltaDisplayedGridPoints * oldInteractionProportion
        sTranslation += displacedTopLeftGridPoints
        gScale *= scaleMultiplier
        self.sInteractionPoint = sInteractionPoint
    }
    
    /// Set the screen size for the grid. The grid's base position is the upper left hand corner, so the grid expands to the right and down
    /// - Parameter screenSize: Size of the grid
    public func setScreenSize(_ screenSize: CGSize) {
        // Ensure valid dimensions
        if !(screenSize.width.isFinite && screenSize.height.isFinite) {
            return
        }
        if screenSize.width * screenSize.height < 1 {
            return
        }
        self.sSize = screenSize
    }
    
    /// Calculates the placement of lines in a path to form a grid
    /// - Returns: The completed Path object
    public func drawGrid() -> Path {
        /// Grid to modify and return.
        var path: Path = Path()
        if gScale <= .zero {
            return path
        }
        
        // Vertical lines
        var pos: CGFloat = (sTranslation.x - floor(sTranslation.x / sLineSpacing) * sLineSpacing) * gScale
        while pos < sSize.width {
            path.move(to: CGPoint(x: pos, y: .zero))
            path.addLine(to: CGPoint(x: pos, y: sSize.height))
            pos += sLineSpacing * gScale
        }
        
        // Horizontal lines
        pos = (sTranslation.y - floor(sTranslation.y / sLineSpacing) * sLineSpacing) * gScale
        while pos < sSize.height {
            path.move(to: CGPoint(x: .zero, y: pos))
            path.addLine(to: CGPoint(x: sSize.width, y: pos))
            pos += sLineSpacing * gScale
        }
        
        return path
    }
}
