import Foundation

public enum ViewType: String, Codable {
    case spacer, vstack, hstack, scroll, image, text, button, overlay, custom
    
    public var allowedAttributes: [ViewAttribute.Type] {
//        switch self {
//        case .spacer: return []
//        case .vstack: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, HorizontalAlignmentAttribute.self, SpacingAttribute.self]
//        case .hstack: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, VerticalAlignmentAttribute.self, SpacingAttribute.self]
//        case .scroll: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self]
//        case .image: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, Base64EncodedImageAttribute.self, URLAttribute.self]
//        case .text: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, TextValueAttribute.self]
//        case .button: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, ActionAttribute.self]
//        case .overlay: return [AccessibilityHeaderAttribute.self, AccessibilityLabelAttribute.self, SpacingAttribute.self]
//        case .custom: return []
//        }
        return []
    }
    
    public var allowChildren: Bool {
        switch self {
        case .spacer: return false
        case .vstack: return true
        case .hstack: return true
        case .scroll: return true
        case .image: return false
        case .text: return false
        case .button: return true
        case .overlay: return true
        case .custom: return true
        }
    }
}
