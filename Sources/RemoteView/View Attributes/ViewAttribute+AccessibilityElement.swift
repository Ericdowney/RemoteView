import Foundation
import SwiftUI

extension ViewAttribute {
    
    public var isAccessibilityElement: Bool {
        item.value as? Bool ?? false
    }
}

struct RemoteAccessibilityElement: ViewModifier {
    
    let element: ViewJsonElement
    
    private var attribute: ViewAttribute? {
        element.attributes.first { $0.key == "accessibilityElement" }
    }
    
    func body(content: Content) -> some View {
        content
            .unwrapAndApply(attribute) { item, view in
                if item?.isAccessibilityElement == true {
                    view.accessibilityElement()
                } else {
                    view
                }
            }
    }
}
