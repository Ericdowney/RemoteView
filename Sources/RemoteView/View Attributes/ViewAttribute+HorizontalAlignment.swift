import Foundation
import SwiftUI

//public final class HorizontalAlignmentAttribute: ViewAttribute {
//    public enum Cases: String, Codable {
//        case leading, trailing, center
//
//        public var alignment: SwiftUI.HorizontalAlignment {
//            switch self {
//            case .leading: return .leading
//            case .trailing: return .trailing
//            case .center: return .center
//            }
//        }
//    }
//
//    public override var key: String { get { "horizontalAlignment" } set {} }
//    public var alignment: Cases {
//        Cases(rawValue: item.value as! String) ?? .center
//    }
//
//    public override func validate() throws {
//        guard let _ = item.value as? Cases else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid alignment case.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var horizontalAlignment: SwiftUI.HorizontalAlignment? {
        guard let stringValue = item.value as? String else {
            return nil
        }
        
        switch stringValue {
        case "leading": return .leading
        case "trailing": return .trailing
        case "center": return .center
        default: return nil
        }
    }
}
