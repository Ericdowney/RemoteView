import SwiftUI

public struct RemoteVStack: RemotableView {
    
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
        element.attributes.first { $0.key == "horizontalAlignment" }
    }
    private var spacing: ViewAttribute? {
        element.attributes.first { $0.key == "spacing" }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        VStack(alignment: alignment?.horizontalAlignment ?? .center, spacing: spacing?.spacing) {
            ForEach(element.children) {
                factory.createView(forElement: $0, style: style, children: $0.children, actionManager: actionManager)
            }
        }
        .id(element.id)
        .modifier(RemoteAccessibilityElement(element: element))
        .modifier(RemoteAccessibilityHeader(element: element))
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

struct RemoteVStack_Previews: PreviewProvider {
    
    static var previews: some View {
        RemoteVStack(element: element, style: nil, factory: .init(), actionManager: .init())
    }
    
    private static var element: ViewJsonElement {
        .init(id: "Test-ID-1",
              name: nil,
              viewType: .vstack,
              attributes: [
                .init(key: "horizontalAlignment", item: "trailing"),
                .init(key: "spacing", item: 8.0)
              ],
              children: [
                .init(id: "Test-ID-2",
                      name: nil,
                      viewType: .text,
                      attributes: [
                        .init(key: "textValue", item: "This is some text.")
                      ],
                      children: []),
                .init(id: "Test-ID-3",
                      name: nil,
                      viewType: .text,
                      attributes: [
                        .init(key: "textValue", item: "This is some other text.")
                      ],
                      children: [])
              ])
    }
}
