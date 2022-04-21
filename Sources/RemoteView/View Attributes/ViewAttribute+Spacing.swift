import Foundation
import SwiftUI

//public final class SpacingAttribute: ViewAttribute {
//
//    // MARK: - Properties
//
//    public override var key: String { get { "spacing" } set {} }
//    public var spacing: CGFloat {
//        CGFloat(item.value as! Double)
//    }
//
//    // MARK: - Lifecycle
//
//    // MARK: - Methods
//
//    public override func validate() throws {
//        guard let floatValue = item.value as? Float else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid Float.")
//        }
//
//        guard floatValue >= 0 else {
//            throw ValidatableError.invalid(reason: "Supplied Float value for \(Self.self) is not greater than zero.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var spacing: CGFloat? {
        CGFloat(item.value as? Double) ?? CGFloat(item.value as? Float)
    }
}
