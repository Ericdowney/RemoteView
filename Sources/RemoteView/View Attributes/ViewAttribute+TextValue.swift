import Foundation

//public final class TextValueAttribute: ViewAttribute {
//
//    // MARK: - Properties
//
//    public override var key: String { get { "textValue" } set {} }
//    public var textValue: String {
//        item.value as! String
//    }
//
//    // MARK: - Lifecycle
//
//    // MARK: - Methods
//
//    public override func validate() throws {
//        guard let _ = item.value as? String else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) must be a valid string.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var textValue: String? {
        item.value as? String
    }
}
