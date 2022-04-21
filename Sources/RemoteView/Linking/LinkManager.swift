import Foundation

open class LinkManager {
    
    // MARK: - Properties
    
    public static let shared: LinkManager = .init()
    
    public weak var delegate: LinkDelegate? = nil
    
    // MARK: - Lifecycle
    
    public init() {}
    
    // MARK: - Methods
    
    open func select(_ link: Link) {
        delegate?.didSelect(link)
    }
}
