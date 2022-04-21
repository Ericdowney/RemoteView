import Foundation

//public final class ActionAttribute: ViewAttribute {
//
//    // MARK: - Properties
//
//    public override var key: String { get { "actionName" } set {} }
//    var actionName: String {
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
    
    public var actionName: String? {
        item.value as? String
    }
}
