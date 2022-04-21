import Foundation
import SwiftUI

//public final class VerticalAlignmentAttribute: ViewAttribute {
//    public enum Cases: String, Codable {
//        case top, bottom, center
//    }
//
//    // MARK: - Properties
//
//    public override var key: String { get { "verticalAlignment" } set {} }
//    public var spacing: Cases {
//        item.value as! Cases
//    }
//
//    // MARK: - Lifecycle
//
//    // MARK: - Methods
//
//    public override func validate() throws {
//        guard let _ = item.value as? Cases else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid alignment case.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var verticalAlignment: SwiftUI.VerticalAlignment? {
        guard let stringValue = item.value as? String else {
            return nil
        }
        
        switch stringValue {
        case "top": return .top
        case "bottom": return .bottom
        case "center": return .center
        default: return nil
        }
    }
}
