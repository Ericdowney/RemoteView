import SwiftUI

public struct RemoteButton: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    let factory: RemoteViewFactory
    let actionManager: ActionsManager
    
    private var actionAttribute: ViewAttribute? {
        element.attributes.first { $0.key == "actionName" }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        Button(action: executeAction) {
            ForEach(element.children) { factory.createView(forElement: $0, style: style, children: $0.children, actionManager: actionManager) }
        }
        .id(element.id)
        .modifier(CornerRadius(element: element))
        .modifier(RemoteAccessibilityElement(element: element))
        .modifier(RemoteAccessibilityLabel(element: element))
    }
    
    private func executeAction() {
        if let actionName = actionAttribute?.actionName {
            actionManager.executeAction(named: actionName)
        }
    }
}
