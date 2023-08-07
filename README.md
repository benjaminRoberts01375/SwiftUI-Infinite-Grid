# SwiftUI Infinite Grid
 A SwiftUI library for creating and interacting with an infinite grid in iOS 17+, macOS 14+, and iPadOS 17+.
# Features
- It's an infinite canvas
- Move in two dimensions
    - Use the mouse/trackpad
    - Use a touch screen
    - Use the arrow keys
    - Use a binding for code use
- Scaling at a location
    - Use the mouse wheel
    - Use a pinch gesture
    - Use a binding for code use
- Pin views for translation. SwiftUI doesn't provide a method to scale views without loss of resolution.
- Theme the grid
- Set scale limits
  
![Gif Repair](https://github.com/benjaminRoberts01375/SwiftUI-Infinite-Grid/assets/61424934/d31b740e-eee4-47b9-b1ac-63c77ad355b7)
![Gestures!](https://github.com/benjaminRoberts01375/SwiftUI-Infinite-Grid/assets/61424934/d08739f2-4023-438a-8b40-91cd02166a1b)

# Installation
The Swift Package Manager is the current installation method for the infinite grid.
1. Open your project in Xcode
2. File > Add Package Dependencies...
3. Copy the repo URL: `https://github.com/benjaminRoberts01375/SwiftUI-Infinite-Grid`
4. Add Package
5. Profit!

# Usage
Once installed, the grid works as most other views do, just with lots of optional parameters.


### Optional parameters:
- **Grid shading**
    - Handles changing the color of the lines.
- **Line thickness**
    - Measured in points.
- **Smallest allowed line gap**
    - Measured in points.
- **Largest allowed line gap**
    - Measured in points.
- **Base scale**
    - Useful for offsetting the scale of the grid for overlapping.
- **Binding: Translation**
    - How far THE GRID is translated. This is the opposite of camera movements.
    - Set to `.constant(.zero)` to prevent translation.
- **Binding: Scale**
    - How zoomed in the grid is.
    - Set to `.constant(.zero)` to prevent translation.
- **Binding: Interaction Point**
    - Where scaling takes place. Useful for scaling in at a particular position.
- **Views**
    - Views to translate on the grid. The grid will not resize the views due to potential desired behavior, and SwiftUI not rendering the view at the updated resolution. To achieve this, use the scale binding to resize your views before being passed into the grid.
