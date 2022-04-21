import Foundation
import SwiftUI

open class RemoteViewFactory {
    
    // MARK: - Properties
    
    public static let shared: RemoteViewFactory = .init()
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    @ViewBuilder
    open func createView(forElement element: ViewJsonElement, style: RemoteViewStyle?, children: [ViewJsonElement], actionManager: ActionsManager) -> some View {
        switch element.viewType {
        case .spacer: RemoteSpacer(element: element, style: style)
        case .vstack: RemoteVStack(element: element, style: style, factory: self, actionManager: actionManager)
        case .hstack: RemoteHStack(element: element, style: style, factory: self, actionManager: actionManager)
        case .scroll: RemoteScroll(element: element, style: style, factory: self, actionManager: actionManager)
        case .image: RemoteImage(element: element, style: style, actionManager: actionManager)
        case .text: RemoteText(element: element, style: style, actionManager: actionManager)
        case .button: RemoteButton(element: element, style: style, factory: self, actionManager: actionManager)
        case .overlay: RemoteOverlay(element: element, style: style, factory: self, actionManager: actionManager)
        case .custom: Rectangle().fill(Color.red)
        }
    }
}

struct TestFactoryJson_Previews: PreviewProvider {
    
    static var previews: some View {
        _RemoteView(style: nil, factory: .shared, actionManager: .shared, remoteViewBuilder: createBuilder())
    }
    
    static func createBuilder() -> RemoteViewBuilder {
        let builder = RemoteViewBuilder()
        builder.rootElement = element
        
        ActionsManager.shared.registerAction(named: "testAction") {
            print("Hello ActionsManager")
        }
        
        return builder
    }
    
    private static var element: ViewJsonElement {
        .init(id: "liajsdgkajgkfhl",
              name: nil,
              viewType: .scroll,
              attributes: [
                .init(key: "scrollAxis", item: "vertical"),
              ],
              children: [
                .init(id: "Test-ID-1",
                      name: nil,
                      viewType: .scroll,
                      attributes: [
                        .init(key: "scrollAxis", item: "horizontal"),
                      ],
                      children: [
                        .init(id: "asdkfljaksldfjasd",
                              name: nil,
                              viewType: .hstack,
                              attributes: [
                                .init(key: "spacing", item: 16.0)
                              ],
                              children: [
                                .init(id: "Test-ID-Image-1",
                                      name: nil,
                                      viewType: .image,
                                      attributes: [
                                        .init(key: "imageUrl", item: "https://www.dccomics.com/sites/default/files/styles/covers192x291/public/comic-covers/2022/03/BMSMWF_Cv2_00211_DIGITAL_6246419c64c9e4.99746513.jpg?itok=wjTi03v3"),
                                        .init(key: "cornerRadius", item: 8.0),
                                      ],
                                      children: []),
                                .init(id: "Test-ID-Image-2",
                                      name: nil,
                                      viewType: .image,
                                      attributes: [
                                        .init(key: "imageUrl", item: "https://www.dccomics.com/sites/default/files/styles/covers192x291/public/comic-covers/2022/01/BM_TK_Cv1_00111_DIGITAL_61d398decf1532.20215229.jpg?itok=YFVRa8R7"),
                                        .init(key: "cornerRadius", item: 8.0),
                                      ],
                                      children: []),
                                .init(id: "Test-ID-Image-3",
                                      name: nil,
                                      viewType: .image,
                                      attributes: [
                                        .init(key: "imageUrl", item: "https://www.dccomics.com/sites/default/files/styles/covers192x291/public/comic-covers/2022/03/BM_TK_Cv4_00411_DIGITAL_624641a86b6949.00280181.jpg?itok=_xe1h-nK"),
                                        .init(key: "cornerRadius", item: 8.0),
                                      ],
                                      children: []),
                                .init(id: "Test-ID-Image-3",
                                      name: nil,
                                      viewType: .image,
                                      attributes: [
                                        .init(key: "imageUrl", item: "https://www.dccomics.com/sites/default/files/styles/covers192x291/public/comic-covers/2022/03/FLS_Cv781_78111_DIGITAL_6246428bd36044.03925988.jpg?itok=rUug61Ka"),
                                        .init(key: "cornerRadius", item: 8.0),
                                      ],
                                      children: []),
                              ]),
                      ]),
                .init(id: "Test-ID-2",
                      name: nil,
                      viewType: .text,
                      attributes: [
                        .init(key: "textValue", item: "This is some text.")
                      ],
                      children: []),
                .init(id: "Test-ID-3",
                      name: nil,
                      viewType: .text,
                      attributes: [
                        .init(key: "textValue", item: "This is some other text.")
                      ],
                      children: []),
                .init(id: "Test-ID-Button-1",
                      name: nil,
                      viewType: .button,
                      attributes: [
                        .init(key: "actionName", item: "testAction"),
                      ],
                      children: [
                        .init(id: "Test-ID-4",
                              name: nil,
                              viewType: .text,
                              attributes: [
                                .init(key: "textValue", item: "Button Text")
                              ],
                              children: [])
                      ]),
            ])
    }
}
