import SwiftUI

public struct RemoteImage: RemotableView {
    
    // MARK: - Properties
    
    public let element: ViewJsonElement
    public let style: RemoteViewStyle?
    
    public var body: some View { viewBody() }
    
    let actionManager: ActionsManager
    
    private var imageUrl: ViewAttribute? {
        element.attributes.first { $0.key == "imageUrl" }
    }
    private var imageData: ViewAttribute? {
        element.attributes.first { $0.key == "base64Image" }
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    private func viewBody() -> some View {
        Group {
            if shouldLoadImageFromURL() {
                AsyncImage(url: imageUrl?.url)
            } else if shouldLoadImageFromData() {
                Image(uiImage: imageData?.base64Image)
            }
        }
        .id(element.id)
        .modifier(CornerRadius(element: element))
        .modifier(RemoteAccessibilityElement(element: element))
        .modifier(RemoteAccessibilityLabel(element: element))
    }
    
    private func shouldLoadImageFromURL() -> Bool {
        imageUrl?.url != nil
    }
    
    private func shouldLoadImageFromData() -> Bool {
        imageData?.base64Image != nil
    }
}

extension Image {
    
    fileprivate init?(uiImage: UIImage?) {
        guard let uiImage = uiImage else {
            return nil
        }

        self.init(uiImage: uiImage)
    }
}

extension AsyncImage {
    
    fileprivate init?(url: URL?) {
        guard let url = url else {
            return nil
        }

        self.init(url: url)
    }
}
