import SwiftUI

public struct RemoteScroll: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    let factory: RemoteViewFactory
    let actionManager: ActionsManager
    
    private var scrollAxis: ViewAttribute? {
        element.attributes.first { $0.key == "scrollAxis" }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        ScrollView(scrollAxis?.scrollAxis ?? .vertical, showsIndicators: true) {
            ForEach(element.children) {
                factory.createView(forElement: $0, style: style, children: $0.children, actionManager: actionManager)
            }
        }
        .id(element.id)
        .modifier(RemoteAccessibilityElement(element: element))
        .modifier(RemoteAccessibilityLabel(element: element))
    }
}
