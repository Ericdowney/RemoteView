import Foundation
import SwiftUI

//public final class AccessibilityLabelAttribute: ViewAttribute {
//    
//    // MARK: - Properties
//    
//    public override var key: String { get { "accessibilityLabel" } set {} }
//    public var label: String {
//        item.value as! String
//    }
//    
//    // MARK: - Lifecycle
//    
//    // MARK: - Methods
//    
//    public override func validate() throws {
//        guard let stringValue = item.value as? String, !stringValue.isEmpty else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid string that is not empty.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var accessibilityLabel: String? {
        item.value as? String
    }
}

struct RemoteAccessibilityLabel: ViewModifier {
    
    let element: ViewJsonElement
    
    private var attribute: ViewAttribute? {
        element.attributes.first { $0.key == "accessibilityLabel" }
    }
    
    func body(content: Content) -> some View {
        content
            .unwrapAndApply(attribute) { item, view in
                view.accessibilityLabel(item.accessibilityLabel ?? "")
            }
    }
}
