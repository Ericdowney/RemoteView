import SwiftUI

public struct RemoteView: View {
    
    // MARK: - Properties
    
    public var body: some View { viewBody() }
    
    let url: URL
    let onRefresh: (() -> Void)?
    let onError: ((Error) -> Void)?
    let style: RemoteViewStyle?
    let factory: RemoteViewFactory
    let actionManager: ActionsManager
    let loadingView: AnyView?
    
    @ObservedObject private var remoteViewBuilder: RemoteViewBuilder = .shared
    @State private var isLoading: Bool = false
    
    // MARK: - Lifecycle
    
    public init(url: URL) {
        self.init(url: url, onRefresh: nil, onError: nil, style: nil, factory: .shared, actionManager: .shared, loadingView: nil)
    }
    
    init(url: URL, onRefresh: (() -> Void)?, onError: ((Error) -> Void)?, style: RemoteViewStyle?, factory: RemoteViewFactory, actionManager: ActionsManager, loadingView: AnyView?) {
        self.url = url
        self.onRefresh = onRefresh
        self.onError = onError
        self.style = style
        self.factory = factory
        self.actionManager = actionManager
        self.loadingView = loadingView
    }
    
    // MARK: - Methods
    
    public func onRefresh(perform: () -> Void) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: actionManager, loadingView: loadingView)
    }
    
    public func onError(perform: (Error) -> Void) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: actionManager, loadingView: loadingView)
    }
    
    public func style(_ style: RemoteViewStyle) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: actionManager, loadingView: loadingView)
    }
    
    public func useViewFactory(_ factory: RemoteViewFactory) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: actionManager, loadingView: loadingView)
    }
    
    public func useActionManager(_ manager: ActionsManager) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: manager, loadingView: loadingView)
    }
    
    public func setLoadingView(@ViewBuilder content: () -> AnyView) -> Self {
        RemoteView(url: url, onRefresh: onRefresh, onError: onError, style: style, factory: factory, actionManager: actionManager, loadingView: content())
    }
    
    @ViewBuilder
    private func viewBody() -> some View {
        Group {
            _RemoteView(style: style, factory: factory, actionManager: actionManager, remoteViewBuilder: remoteViewBuilder)
        }
        .onAppear(perform: fetchData)
    }
    
    private func fetchData() {
        isLoading = true
        
        Task(priority: .userInitiated) {
            do {
                try await remoteViewBuilder.fetchView(from: url)
                DispatchQueue.main.async {
                    isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                    onError?(error)
                }
            }
        }
    }
    
    private func refresh() {
        isLoading = true
        
        Task(priority: .userInitiated) {
            do {
                try await remoteViewBuilder.refresh()
                DispatchQueue.main.async {
                    isLoading = false
                    onRefresh?()
                }
            } catch {
                DispatchQueue.main.async {
                    isLoading = false
                    onError?(error)
                }
            }
        }
    }
}

struct _RemoteView: View {
    
    // MARK: - Properties
    
    let style: RemoteViewStyle?
    let factory: RemoteViewFactory
    let actionManager: ActionsManager
    
    var body: some View { viewBody() }
    
    @ObservedObject var remoteViewBuilder: RemoteViewBuilder
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        VStack {
            remoteViewBuilder.rootElement.map { element in
                factory.createView(forElement: element, style: style, children: element.children, actionManager: actionManager)
            }
        }
    }
}
