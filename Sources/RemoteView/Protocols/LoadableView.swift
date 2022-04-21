import SwiftUI

public protocol LoadableView: View {
    
    func startLoading()
    func stopLoading()
}
