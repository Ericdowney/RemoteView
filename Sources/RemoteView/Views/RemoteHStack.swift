import SwiftUI

public struct RemoteHStack: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    let factory: RemoteViewFactory
    let actionManager: ActionsManager
    
    private var action: ViewAttribute? {
        element.attributes.first { $0.key == "actionName" }
    }
    private var alignment: ViewAttribute? {
        element.attributes.first { $0.key == "verticalAlignment" }
    }
    private var spacing: ViewAttribute? {
        element.attributes.first { $0.key == "spacing" }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        HStack(alignment: alignment?.verticalAlignment ?? .center, spacing: spacing?.spacing) {
            ForEach(element.children) {
                factory.createView(forElement: $0, style: style, children: $0.children, actionManager: actionManager)
            }
        }
        .id(element.id)
        .modifier(RemoteAccessibilityElement(element: element))
        .modifier(RemoteAccessibilityLabel(element: element))
        .unwrapAndApply(action) { item, view in
            if item.actionName != nil {
                view.onTapGesture(count: 1) {
                    actionManager.executeAction(named: item.actionName.unsafelyUnwrapped)
                }
            }
        }
    }
}
