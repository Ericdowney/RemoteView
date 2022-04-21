import SwiftUI

public struct RemoteText: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    let actionManager: ActionsManager
    
    private var action: ViewAttribute? {
        element.attributes.first { $0.key == "actionName" }
    }
    private var textAttribute: ViewAttribute? {
        element.attributes.first { $0.key == "textValue" }
    }
    private var textValue: String? {
        textAttribute?.item.value as? String
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        Text(verbatim: textValue ?? "")
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

struct RemoteText_Previews: PreviewProvider {
    
    static var previews: some View {
        RemoteText(element: element, style: nil, actionManager: .init())
    }
    
    private static var element: ViewJsonElement {
        .init(id: "Test-ID",
              name: nil,
              viewType: .text,
              attributes: [.init(key: "textValue", item: "Some Text Value")],children: [])
    }
}
