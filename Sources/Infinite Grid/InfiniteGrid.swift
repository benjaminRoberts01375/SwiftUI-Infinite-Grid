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

import Combine
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
/// A pre-fab view for the Infinite Canvas that allows for a grid to be drawn to the screen.
public struct InfiniteGrid: View {
    /// View model for the infinite canvas.
    private var controller: InfiniteGridVM
    /// The net translation during a drag gesture.
    @State private var previousFrameTranslation: CGSize
    /// The net scale during a magnify gesture.
    @State private var previousFrameScale: CGFloat
    /// The shading for the grid lines.
    private let gridShading: GraphicsContext.Shading
    /// Thickness of the grid lines.
    private let lineThickness: CGFloat
    /// Views to display on grid.
    private let views: [any GridObject]
    /// Cancellable for updating grid on scrollwheel change.
    @State var scrollWheelCancellable = Set<AnyCancellable>() // Cancel onDisappear
    /// Latest hash for scrollwheel event to prevent redundant firings.
    @State var eventHash: Int = .zero
    /// Stores the mouse position (if applicable)
    @State var mousePos: CGPoint

    /// A pre-fab view for the Infinite Canvas that allows for a grid to be drawn to the screen.
    /// - Parameters:
    ///   - gridShading: Shading for the grid lines. Default is the primary color
    ///   - baseScale: Scale offset. Helpful for when multiple grids are overlaid with eachother.
    ///   - lineSpacing: Gap between lines at a 1.0 scale in points.
    ///   - smallestAllowedLineGap: The smallest allowed gap between lines in points. This dictates the smallest allowed scale.
    ///   - largestAllowedLineGap: The largest allowed gap between lines in points. This dictates the largest allowed scale.
    ///   - translation: Binding for the translation OF THE GRID, not the camera. Default value prevents any translation.
    ///   - scale: Binding for the scale of the grid. Default value prevents any scaling.
    ///   - interactionPoint: Binding for the scale interaction point. Default value is at the zero point.
    ///   - views: An array of views to be rendered on the grid.
    public init(
        gridShading: GraphicsContext.Shading = .color(.black),
        lineThickness: CGFloat = 2,
        smallestAllowedLineGap: CGFloat = 10,
        largestAllowedLineGap: CGFloat = 500,
        baseScale: CGFloat = 1,
        translation: Binding<CGPoint> = .constant(.zero),
        scale: Binding<CGFloat> = .constant(1),
        interactionPoint: Binding<CGPoint> = .constant(.zero),
        views: [any GridObject] = []
    ) {
        self.controller = InfiniteGridVM(
            baseScale: baseScale,
            smallestAllowedLineGap: smallestAllowedLineGap,
            largestAllowedLineGap: largestAllowedLineGap,
            translation: translation.wrappedValue,
            scale: scale.wrappedValue,
            interactionPoint: interactionPoint.wrappedValue
        )
        self._previousFrameTranslation = State(initialValue: .zero)
        self._previousFrameScale = State(initialValue: 1)
        self.gridShading = gridShading
        self.lineThickness = lineThickness
        self.views = views
        self._mousePos = State(initialValue: .zero)
    }

    /// Gesture for moving the grid when dragging
    private var gridDrag: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { update in
                /// Get the distance traveled between frames.
                let currentFrameTranslation: CGSize = update.translation - previousFrameTranslation
                // Update the translation
                controller.updateTranslation(newTranslation: currentFrameTranslation)
                // Save the new translation
                previousFrameTranslation = update.translation
            }
            .onEnded { _ in
                previousFrameTranslation = .zero
            }
    }
    
    /// Gesture to scale the grid when using a magnify gesture
    private var gridScale: some Gesture {
        MagnifyGesture()
            .onChanged { update in
                /// Determine how much larger this frame is
                let currentFrameScale: CGFloat = update.magnification / previousFrameScale
                // Update the scale
                controller.updateScale(newScale: currentFrameScale, sInteractionPoint: update.startLocation)
                // Save the current scale
                previousFrameScale = update.magnification
            }
            .onEnded { _ in
                // Reset the stored previous frame scale
                previousFrameScale = 1
            }
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
#if os(macOS)
            Color.clear // Zoom via scrollwheel
                .trackingMouse { mousePos in
                    self.mousePos = mousePos
                }
                .onAppear { trackScrollWheel() }
#endif
            Color.clear // Zoom via keyboard
                .focusable()
                .focusEffectDisabled()
                .onKeyPress(KeyEquivalent("=")) { // Plus button
                    controller.updateScale(newScale: 1.1, sInteractionPoint: mousePos)
                    return .handled
                }
                .onKeyPress(KeyEquivalent("+")) { // Numpad plus button
                    controller.updateScale(newScale: 1.1, sInteractionPoint: mousePos)
                    return .handled
                }
                .onKeyPress(KeyEquivalent("-")) { // Minus button
                    controller.updateScale(newScale: 0.9, sInteractionPoint: mousePos)
                    return .handled
                }
                .onKeyPress(.leftArrow) { // Left arrow
                    controller.updateTranslation(newTranslation: CGSize(width: controller.sLineSpacing * controller.gScale, height: 0))
                    return .handled
                }
                .onKeyPress(.rightArrow) { // Right arrow
                    controller.updateTranslation(newTranslation: CGSize(width: -controller.sLineSpacing * controller.gScale, height: 0))
                    return .handled
                }
                .onKeyPress(.upArrow) { // Up arrow
                    controller.updateTranslation(newTranslation: CGSize(width: 0, height: controller.sLineSpacing * controller.gScale))
                    return .handled
                }
                .onKeyPress(.downArrow) { // Down arrow
                    controller.updateTranslation(newTranslation: CGSize(width: 0, height: -controller.sLineSpacing * controller.gScale))
                    return .handled
                }
            Canvas { context, size in // Grid
                controller.setScreenSize(size)
                context.stroke(controller.drawGrid(), with: gridShading, lineWidth: lineThickness)
            }
            .gesture(gridDrag)
            ForEach(Array(zip(views.indices, views)), id: \.0) { _, gridObject in // Views to show on grid
                AnyView(gridObject)
                    .fixedSize()
                    .position(
                        CGPoint(
                            x: (gridObject.pos.x + controller.sTranslation.x) * controller.gScale,
                            y: (gridObject.pos.y + controller.sTranslation.y) * controller.gScale
                        )
                    )
            }
        }
        .gesture(gridScale)
        .clipped()
    }
    
#if os(macOS)
    /// Track the change in scroll wheel
    func trackScrollWheel() {
        NSApp.publisher(for: \.currentEvent)
            .filter { event in event?.type == .scrollWheel }
            .sink { event in
                guard let newEvent = event else { return }
                if newEvent.hashValue == eventHash {
                    return
                }
                if newEvent.deltaY > 0 { // Scrolled up
                    controller.updateScale(newScale: 1.1, sInteractionPoint: mousePos)
                }
                else if newEvent.deltaY < 0 { // Scrolled down
                    controller.updateScale(newScale: 0.9, sInteractionPoint: mousePos)
                }
                eventHash = newEvent.hashValue // Track the hash to prevent repeats
            }
            .store(in: &scrollWheelCancellable)
    }
#endif
}
