import Foundation
import SwiftUI

//public final class URLAttribute: ViewAttribute {
//
//    // MARK: - Properties
//
//    public override var key: String { get { "url" } set {} }
//    public var url: URL {
//        URL(string: item.value as! String)!
//    }
//
//    // MARK: - Lifecycle
//
//    // MARK: - Methods
//
//    public override func validate() throws {
//        guard let urlString = item.value as? String, let _ = URL(string: urlString) else {
//            throw ValidatableError.invalid(reason: "Supplied value for \(Self.self) is not a valid URL string.")
//        }
//    }
//}

extension ViewAttribute {
    
    public var url: URL? {
        guard let stringValue = item.value as? String else {
            return nil
        }
        
        return URL(string: stringValue)
    }
}
