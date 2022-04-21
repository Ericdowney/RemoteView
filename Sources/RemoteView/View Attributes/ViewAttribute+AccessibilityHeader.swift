import Foundation
import SwiftUI

//public final class AccessibilityHeaderAttribute: ViewAttribute {
//    public enum HeaderLevel: Int, Codable {
//        case h1, h2, h3, h4, h5, h6
//    }
//
//    // MARK: - Properties
//
//    public override var key: String { get { "accessibilityHeader" } set {} }
//    public var headerLevel: HeaderLevel {
//        switch item.value as? String {
//        case "h1": return .h1
//        case "h2": return .h2
//        case "h3": return .h3
//        case "h4": return .h4
//        case "h5": return .h5
//        case "h6": return .h6
//        default: fatalError()
//        }
//    }
//
//    // MARK: - Lifecycle
//
//    // MARK: - Methods
//
//    public override func validate() throws {
//        guard let stringValue = item.value as? String else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid header string.")
//        }
//        guard ["h1","h2","h3","h4","h5","h6"].contains(stringValue) else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid header level.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var accessibilityHeader: SwiftUI.AccessibilityHeadingLevel? {
        switch item.value as? String {
        case "h1": return .h1
        case "h2": return .h2
        case "h3": return .h3
        case "h4": return .h4
        case "h5": return .h5
        case "h6": return .h6
        default: return nil
        }
    }
}

struct RemoteAccessibilityHeader: ViewModifier {
    
    let element: ViewJsonElement
    
    private var attribute: ViewAttribute? {
        element.attributes.first { $0.key == "accessibilityHeader" }
    }
    
    func body(content: Content) -> some View {
        content
            .unwrapAndApply(attribute) { item, view in
                view.accessibilityHeading(item?.accessibilityHeader ?? .unspecified)
            }
    }
}
