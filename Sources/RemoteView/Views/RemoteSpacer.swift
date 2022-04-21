import SwiftUI

public struct RemoteSpacer: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        Spacer()
            .id(element.id)
    }
}
