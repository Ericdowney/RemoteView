import Foundation

public final class RemoteViewBuilder: ObservableObject {
    enum Errors: Error {
        case invalidCachedUrl
    }
    
    // MARK: - Properties
    
    public static let shared: RemoteViewBuilder = .init()
    
    @Published var rootElement: ViewJsonElement?
    
    private var linkManager: LinkManager
    private var actionsManager: ActionsManager
    private var cachedUrl: URL?
    
    // MARK: - Lifecycle
    
    public init(linkManager: LinkManager = .shared, actionsManager: ActionsManager = .shared) {
        self.linkManager = linkManager
        self.actionsManager = actionsManager
        self.rootElement = nil
        self.cachedUrl = nil
    }
    
    // MARK: - Methods
    
    public func setView(from json: ViewJsonElement) throws {
        self.rootElement = json
    }
    
    public func fetchView(from url: URL) async throws {
        cachedUrl = url
        try await fetchDataFromCachedURL()
    }
    
    public func refresh() async throws {
        try await fetchDataFromCachedURL()
    }
    
    private func fetchDataFromCachedURL() async throws {
        guard let cachedUrl = cachedUrl else {
            throw Errors.invalidCachedUrl
        }

        let (data, _) = try await URLSession.shared.data(from: cachedUrl)
        let jsonData = try JSONDecoder().decode(ViewJsonElement.self, from: data)
        try jsonData.validate()
        
        rootElement = jsonData
    }
}

public struct ViewJsonElement: Codable, Identifiable, Validatable {
    
    // MARK: - Properties
    
    public let id: String
    public let name: String?
    public let viewType: ViewType
    public let attributes: [ViewAttribute]
    public let children: [ViewJsonElement]
    
    // MARK: - Lifecycle
    
    public init(id: String,
                name: String?,
                viewType: ViewType,
                attributes: [ViewAttribute],
                children: [ViewJsonElement]) {
        self.id = id
        self.name = name
        self.viewType = viewType
        self.attributes = attributes
        self.children = children
    }
    
    // MARK: - Methods
    
    public func validate() throws {
        guard !id.isEmpty else {
            throw ValidatableError.invalid(reason: "Identifier for \(Self.self) is empty. Please provide a a valid id.")
        }
        
        try validateAttributes()
        try validateChildren()
    }
    
    private func validateChildren() throws {
        if !viewType.allowChildren {
            if children.count > 0 {
                throw ValidatableError.invalid(reason: "\(Self.self) is not allowed to have child elements, but child elements have been specified.")
            }
        } else {
            try children.forEach {
                try $0.validate()
            }
        }
    }
    
    private func validateAttributes() throws {
        try attributes.forEach { attribute in
            guard viewType.allowedAttributes.contains(where: { type(of: attribute) == $0 }) else {
                throw ValidatableError.invalid(reason: "ViewAttribute \(attribute.self) is not an allowed attribute for \(Self.self).")
            }
            
            try attribute.validate()
        }
    }
}
