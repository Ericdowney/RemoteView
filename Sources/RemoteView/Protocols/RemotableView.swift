import Foundation
import SwiftUI

public protocol RemotableView: View {
    
    var element: ViewJsonElement { get }
    var style: RemoteViewStyle? { get }
}
