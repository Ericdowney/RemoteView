import Foundation

public protocol Validatable {
    
    func validate() throws
}

public enum ValidatableError: Error {
    
    case invalid(reason: String)
}
