import Foundation

open class ActionsManager {
    public typealias Action = () -> Void
    
    // MARK: - Properties
    
    public static let shared: ActionsManager = .init()
    
    private var actionsRegistry: [String: Action]
    
    // MARK: - Lifecycle
    
    public init() {
        self.actionsRegistry = [:]
    }
    
    // MARK: - Methods
    
    open func registerAction(named: String, _ action: @escaping Action) {
        actionsRegistry[named] = action
    }
    
    func executeAction(named: String) {
        actionsRegistry[named]?()
    }
}
