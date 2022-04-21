import Foundation
import SwiftUI

extension ViewAttribute {
    
    public var cornerRadius: CGFloat? {
        CGFloat(item.value as? Double) ?? CGFloat(item.value as? Float)
    }
}

struct CornerRadius: ViewModifier {
    
    let element: ViewJsonElement
    
    private var attribute: ViewAttribute? {
        element.attributes.first { $0.key == "cornerRadius" }
    }
    
    func body(content: Content) -> some View {
        content
            .unwrapAndApply(attribute) { item, view in
                view.cornerRadius(item.cornerRadius.unsafelyUnwrapped)
            }
    }
}
