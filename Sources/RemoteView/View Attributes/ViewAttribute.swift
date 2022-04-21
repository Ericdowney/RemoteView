import Foundation
import AnyCodable

open class ViewAttribute: Codable, Validatable {
    
    // MARK: - Properties
    
    open var key: String
    open var item: AnyCodable
    
    // MARK: - Lifecycle
    
    public init(key: String, item: AnyCodable) {
        self.key = key
        self.item = item
    }
    
    // MARK: - Methods
    
    open func validate() throws {
        
    }
}
