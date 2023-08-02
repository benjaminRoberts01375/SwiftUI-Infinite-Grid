// Created by Javier at The SwiftUI Lab
//
// Swift 5.0
//

import SwiftUI

#if os(macOS)
@available(macOS 14.0, *)
// Code from The SwiftUI Lab - https://swiftui-lab.com/a-powerful-combo/
extension View {
    func trackingMouse(onMove: @escaping (CGPoint) -> Void) -> some View {
        TrackingAreaView(onMove: onMove) { self }
    }
}

@available(macOS 14.0, *)
struct TrackingAreaView<Content>: View where Content: View {
    let onMove: (NSPoint) -> Void
    let content: () -> Content
    
    init(onMove: @escaping (NSPoint) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.onMove = onMove
        self.content = content
    }
    
    var body: some View {
        TrackingAreaRepresentable(onMove: onMove, content: self.content())
    }
}

@available(macOS 14.0, *)
struct TrackingAreaRepresentable<Content>: NSViewRepresentable where Content: View {
    let onMove: (NSPoint) -> Void
    let content: Content
    
    func makeNSView(context: Context) -> NSHostingView<Content> {
        return TrackingNSHostingView(onMove: onMove, rootView: self.content)
    }
    
    func updateNSView(_ nsView: NSHostingView<Content>, context: Context) { }
}

@available(macOS 14.0, *)
class TrackingNSHostingView<Content>: NSHostingView<Content> where Content: View {
    let onMove: (NSPoint) -> Void
    
    init(onMove: @escaping (NSPoint) -> Void, rootView: Content) {
        self.onMove = onMove
        
        super.init(rootView: rootView)
        
        setupTrackingArea()
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }
    
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTrackingArea() {
        let options: NSTrackingArea.Options = [.mouseMoved, .activeAlways, .inVisibleRect]
        self.addTrackingArea(NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil))
    }
        
    override func mouseMoved(with event: NSEvent) {
        self.onMove(self.convert(event.locationInWindow, from: nil))
    }
}
#endif
